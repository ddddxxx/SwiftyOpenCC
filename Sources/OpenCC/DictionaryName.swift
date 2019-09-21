//
//  DictionaryName.swift
//  OpenCC
//
//  Created by ddddxxx on 2019/9/16.
//

import Foundation

extension ChineseConverter {
    
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
}

extension ChineseConverter.Options {
    
    var segmentationDictName: ChineseConverter.DictionaryName {
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
    
    var conversionChain: [[ChineseConverter.DictionaryName]] {
        var result: [[ChineseConverter.DictionaryName]] = []
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
