//
//  OpenCCConverter.swift
//  OpenCC
//
//  Created by 邓翔 on 2017/3/9.
//
//

import Foundation
import OpenCCBridge

public class OpenCCConverter {
    
    let converter: ObjcConverter
    
    public init() {
        let config = Bundle(for: OpenCCConverter.self).path(forResource: "s2t", ofType: "json")!
        converter = ObjcConverter(config: config)
    }
    
    public func convert(_ text: String) -> String {
        return converter.convert(text)
    }
    
}
