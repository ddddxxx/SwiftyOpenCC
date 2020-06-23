//
//  DictionaryLoader.swift
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

import Foundation
import copencc

extension ChineseConverter {

    class DictionaryLoader {
        
        private static let subdirectory = "Dictionary"
        private static let dictCache = WeakValueCache<String, ConversionDictionary>()
        
        init() {}
        
        func dict(_ name: ChineseConverter.DictionaryName) throws -> ConversionDictionary {
            guard let path = Bundle.module.path(forResource: name.description, ofType: "ocd2", inDirectory: DictionaryLoader.subdirectory) else {
                throw ConversionError.fileNotFound
            }
            return try DictionaryLoader.dictCache.value(for: path) {
                return try ConversionDictionary(path: path)
            }
        }
    }
}

extension ChineseConverter.DictionaryLoader {
    
    func segmentation(options: ChineseConverter.Options) throws -> ConversionDictionary {
        let dictName = options.segmentationDictName
        return try dict(dictName)
    }
    
    func conversionChain(options: ChineseConverter.Options) throws -> [ConversionDictionary] {
        return try options.conversionChain.compactMap { names in
            switch names.count {
            case 0:
                return nil
            case 1:
                return try dict(names.first!)
            case _:
                let dicts = try names.map(dict)
                return ConversionDictionary(group: dicts)
            }
        }
    }
}
