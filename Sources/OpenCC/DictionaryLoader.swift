//
//  DictionaryLoader.swift
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

import Foundation
import OpenCCBridge

extension ChineseConverter {

    class DictionaryLoader {
        
        private static let subdirectory = "Dictionary"
        private static let dictCache = NSMapTable<NSURL, CCDict>(valueOptions: .weakMemory)
        
        private let bundle: Bundle
        
        init(bundle: Bundle) {
            self.bundle = bundle
        }
        
        func dict(_ name: ChineseConverter.DictionaryName) throws -> CCDict {
            guard let url = bundle.url(forResource: name.rawValue, withExtension: "ocd", subdirectory: DictionaryLoader.subdirectory) else {
                let desc = "File \"\(name)\" not found"
                throw NSError(domain: kOpenCCErrorDomain,
                              code: OpenCCErrorCode.fileNotFound.rawValue,
                              userInfo: [NSLocalizedDescriptionKey: desc])
            }
            if let dict = DictionaryLoader.dictCache.object(forKey: url as NSURL) {
                return dict
            }
            let dict = try CCDict(url: url)
            DictionaryLoader.dictCache.setObject(dict, forKey: url as NSURL)
            return dict
        }
    }
}

extension ChineseConverter.DictionaryLoader {
    
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
