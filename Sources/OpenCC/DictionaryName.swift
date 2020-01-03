//
//  DictionaryName.swift
//  OpenCC
//
//  Created by ddddxxx on 2019/9/16.
//

import Foundation

extension ChineseConverter {
    
    enum DictionaryName: String {
        case hkVariants
        case hkVariantsPhrases
        case hkVariantsRev
        case hkVariantsRevPhrases
        case jpVariants
        case stCharacters
        case stPhrases
        case tsCharacters
        case tsPhrases
        case twPhrases
        case twPhrasesRev
        case twVariants
        case twVariantsRev
        case twVariantsRevPhrases
    }
}

extension ChineseConverter.Options {
    
    var segmentationDictName: ChineseConverter.DictionaryName {
        if contains(.traditionalize) {
            return .stPhrases
        } else if contains(.simplify) {
            return .tsPhrases
        } else if contains(.hkStandard) {
            return .hkVariants
        } else if contains(.twStandard) {
            return .twVariants
        } else {
            return .stPhrases
        }
    }
    
    var conversionChain: [[ChineseConverter.DictionaryName]] {
        var result: [[ChineseConverter.DictionaryName]] = []
        if contains(.traditionalize) {
            result.append([.stPhrases, .stCharacters])
            if contains(.twIdiom) {
                result.append([.twPhrases])
            }
            if contains(.hkStandard) {
                result.append([.hkVariantsPhrases, .hkVariants])
            } else if contains(.twStandard) {
                result.append([.twVariants])
            }
        } else if contains(.simplify) {
            if contains(.hkStandard) {
                result.append([.hkVariantsRevPhrases, .hkVariantsRev])
            } else if contains(.twStandard) {
                result.append([.twVariantsRevPhrases, .twVariantsRev])
            }
            if contains(.twIdiom) {
                result.append([.twPhrasesRev])
            }
            result.append([.tsPhrases, .tsCharacters])
        } else {
            if contains(.hkStandard) {
                result.append([.hkVariants])
            } else if contains(.twStandard) {
                result.append([.twVariants])
            }
        }
        if result.isEmpty {
            return [[.stPhrases, .stCharacters]]
        }
        return result
    }
}
