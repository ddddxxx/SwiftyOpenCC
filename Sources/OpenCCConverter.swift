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
    
    public init(option: Options) {
        let config = option.config
        converter = ObjcConverter(config: config)
    }
    
    public func convert(_ text: String) -> String {
        return converter.convert(text)
    }
    
}

extension OpenCCConverter {
    
    public struct Options: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let traditionalize = Options(rawValue: 1 << 0)
        
        public static let simplify = Options(rawValue: 1 << 1)
        
        public static let TWStandard = Options(rawValue: 1 << 5)
        
        public static let HKStandard = Options(rawValue: 1 << 6)
        
        public static let TWIdiom = Options(rawValue: 1 << 10)
        
        var config: String {
            var options = self
            
            if options.contains([.traditionalize, .simplify]) {
                options.remove(.simplify)
            }
            if options.contains([.HKStandard, .TWStandard]) {
                options.remove([.HKStandard, .TWStandard])
            }
            if options.contains(.TWIdiom), !options.contains(.TWStandard) {
                options.remove(.TWIdiom)
            }
            
            let name: String
            switch options {
            case [.traditionalize]:
                name = "s2t"
            case [.simplify]:
                name = "t2s"
            case [.traditionalize, .TWStandard]:
                name = "s2tw"
            case [.simplify, .TWStandard]:
                name = "tw2s"
            case [.traditionalize, .HKStandard]:
                name = "s2hk"
            case [.simplify, .HKStandard]:
                name = "hk2s"
            case [.traditionalize, .TWStandard, .TWIdiom]:
                name = "s2twp"
            case [.simplify, .TWStandard, .TWIdiom]:
                name = "tw2sp"
            case [.TWStandard]:
                name = "t2tw"
            case [.HKStandard]:
                name = "t2hk"
            default:
                name = "s2t"
            }
            
            return Bundle(for: OpenCCConverter.self).path(forResource: name, ofType: "json")!
        }
        
    }
    
}
