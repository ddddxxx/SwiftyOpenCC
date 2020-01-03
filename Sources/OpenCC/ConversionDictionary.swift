//
//  ConversionDictionary.swift
//  OpenCC
//
//  Created by ddddxxx on 2020/1/3.
//

import Foundation
import copencc

class ConversionDictionary {
    
    let dict: CCDictRef
    
    init(contentOf url: URL) throws {
        guard let dict = CCDictCreateWithPath(url.path) else {
            throw ConversionError(ccErrorno)
        }
        self.dict = dict
    }
    
    init(group: [ConversionDictionary]) {
        var rawGroup = group.map { $0.dict }
        self.dict = CCDictCreateWithGroup(&rawGroup, rawGroup.count)
    }
}
