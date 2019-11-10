//
//  DictionaryLoader.swift
//  OpenCC
//
//  Created by ddddxxx on 2018/5/5.
//

import Foundation
import OpenCCBridge

extension OpenCCBridge.CCErrorCode: Error {}

extension ChineseConverter {

    class DictionaryLoader {
        
        private static let subdirectory = "Dictionary"
//        private static let dictCache = NSMapTable<NSURL, CCDictRef>(valueOptions: .weakMemory)
        
        private let bundle: Bundle
        
        init(bundle: Bundle) {
            self.bundle = bundle
        }
        
        func dict(_ name: ChineseConverter.DictionaryName) throws -> CCDictRef {
            guard let url = bundle.url(forResource: name.rawValue, withExtension: "ocd", subdirectory: DictionaryLoader.subdirectory) else {
                throw OpenCCBridge.CCErrorCode.fileNotFound
            }
//            if let dict = DictionaryLoader.dictCache.object(forKey: url as NSURL) {
//                return dict
//            }
            guard let dict = CCDictCreateWithPath(url.path) else {
                throw ccErrorno
            }
//            DictionaryLoader.dictCache.setObject(dict, forKey: url as NSURL)
            return dict
        }
    }
}

extension ChineseConverter.DictionaryLoader {
    
    func segmentation(options: ChineseConverter.Options) throws -> CCDictRef {
        let dictName = options.segmentationDictName
        return try dict(dictName)
    }
    
    func conversionChain(options: ChineseConverter.Options) throws -> [CCDictRef] {
        return try options.conversionChain.compactMap { names in
            switch names.count {
            case 0:
                return nil
            case 1:
                return try dict(names.first!)
            case _:
                var dicts = try names.map(dict)
                return CCDictCreateWithGroup(&dicts, dicts.count)
            }
        }
    }
}
