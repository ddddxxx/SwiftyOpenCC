//
//  ChineseConverter.swift
//  OpenCC
//
//  Created by ddddxxx on 2017/3/9.
//

import Foundation
import OpenCCBridge

/// The `ChineseConverter` class is used to represent and apply conversion
/// between Traditional Chinese and Simplified Chinese to Unicode strings.
/// An instance of this class is an immutable representation of a compiled
/// conversion pattern.
///
/// The `ChineseConverter` supporting character-level conversion, phrase-level
/// conversion, variant conversion and regional idioms among Mainland China,
/// Taiwan and HongKong
///
/// `ChineseConverter` is designed to be immutable and threadsafe, so that
/// a single instance can be used in conversion on multiple threads at once.
/// However, the string on which it is operating should not be mutated
/// during the course of a conversion.
public class ChineseConverter {
    
    /// These constants define the ChineseConverter options.
    public struct Options: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        /// Convert to Traditional Chinese. (default)
        public static let traditionalize = Options(rawValue: 1 << 0)
        
        /// Convert to Simplified Chinese.
        public static let simplify = Options(rawValue: 1 << 1)
        
        /// Using Taiwan standard.
        public static let TWStandard = Options(rawValue: 1 << 5)
        
        /// Using HongKong standard.
        public static let HKStandard = Options(rawValue: 1 << 6)
        
        /// Taiwanese idiom conversion. Only effective with `.TWStandard`.
        public static let TWIdiom = Options(rawValue: 1 << 10)
    }
    
    private let converter: CCConverter
    
    private init(loader: DictionaryLoader, option: Options) throws {
        let seg = try loader.segmentation(options: option)
        let chain = try loader.conversionChain(options: option)
        converter = CCConverter(name: "SwiftyOpenCC",
                                segmentation: seg,
                                conversionChain: chain)
    }
    
    /// Returns an initialized `ChineseConverter` instance with the specified
    /// conversion option.
    ///
    /// - Parameter bundle: The bundle in which to search for the dictionary
    ///   file. This method looks for the dictionary file in the bundle's
    ///   `Resources/Dictionary/` directory. Default to the main bundle.
    /// - Parameter option: The convert’s option.
    public convenience init(bundle: Bundle = .main, option: Options) throws {
        let loader = DictionaryLoader(bundle: bundle)
        try self.init(loader: loader, option: option)
    }
    
    /// Return a converted string using the convert’s current option.
    ///
    /// - Parameter text: The string to convert.
    /// - Returns: A converted string using the convert’s current option.
    public func convert(_ text: String) -> String {
        do {
            return try converter.convert(text)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
}
