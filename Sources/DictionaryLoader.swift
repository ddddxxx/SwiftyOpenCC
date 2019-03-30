//
//  DictionaryLoader.swift
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

import Foundation
import OpenCCBridge

private let subdirectory = "Dictionary"
private let dictCache = NSMapTable<NSURL, CCDict>(valueOptions: .weakMemory)

class DictionaryLoader {
    
    private let bundle: Bundle
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func segmentation(options: ChineseConverter.Options) throws -> CCDict {
        let dictName = options.segmentationDictName
        return try dict(dictName)
    }
    
    func conversionChain(options: ChineseConverter.Options) throws -> [CCDict] {
        return try options.conversionChain.compactMap { names in
            switch names.count {
            case 0:
                return nil
            case 1:
                return try dict(names.first!)
            case _:
                return CCDict(dicts: try names.map(dict))
            }
        }
    }
}

private extension DictionaryLoader {
    
    enum DictionaryName: String {
        case HKVariants
        case HKVariantsPhrases
        case HKVariantsRev
        case HKVariantsRevPhrases
        case JPVariants
        case STCharacters
        case STPhrases
        case TSCharacters
        case TSPhrases
        case TWPhrases
        case TWPhrasesRev
        case TWVariants
        case TWVariantsRev
        case TWVariantsRevPhrases
    }
    
    func dict(_ name: DictionaryName) throws -> CCDict {
        guard let url = bundle.url(forResource: name.rawValue, withExtension: "ocd", subdirectory: subdirectory) else {
            let desc = "File \"\(name)\" not found"
            throw NSError(domain: kOpenCCErrorDomain,
                          code: OpenCCErrorCode.fileNotFound.rawValue,
                          userInfo: [NSLocalizedDescriptionKey: desc])
        }
        if let dict = dictCache.object(forKey: url as NSURL) {
            return dict
        }
        let dict = try CCDict(url: url)
        dictCache.setObject(dict, forKey: url as NSURL)
        return dict
    }
}

private extension ChineseConverter.Options {
    
    var segmentationDictName: DictionaryLoader.DictionaryName {
        if contains(.traditionalize) {
            return .STPhrases
        } else if contains(.simplify) {
            return .TSPhrases
        } else if contains(.HKStandard) {
            return .HKVariants
        } else if contains(.TWStandard) {
            return .TWVariants
        } else {
            return .STPhrases
        }
    }
    
    var conversionChain: [[DictionaryLoader.DictionaryName]] {
        var result: [[DictionaryLoader.DictionaryName]] = []
        if contains(.traditionalize) {
            result.append([.STPhrases, .STCharacters])
            if contains(.TWIdiom) {
                result.append([.TWPhrases])
            }
            if contains(.HKStandard) {
                result.append([.HKVariantsPhrases, .HKVariants])
            } else if contains(.TWStandard) {
                result.append([.TWVariants])
            }
        } else if contains(.simplify) {
            if contains(.HKStandard) {
                result.append([.HKVariantsRevPhrases, .HKVariantsRev])
            } else if contains(.TWStandard) {
                result.append([.TWVariantsRevPhrases, .TWVariantsRev])
            }
            if contains(.TWIdiom) {
                result.append([.TWPhrasesRev])
            }
            result.append([.TSPhrases, .TSCharacters])
        } else {
            if contains(.HKStandard) {
                result.append([.HKVariants])
            } else if contains(.TWStandard) {
                result.append([.TWVariants])
            }
        }
        if result.isEmpty {
            return [[.STPhrases, .STCharacters]]
        }
        return result
    }
}
