//
//  Deprecated.swift
//  OpenCC
//
//  Created by ddddxxx on 2020/1/3.
//

extension ChineseConverter.Options {
    
    @available(*, deprecated, renamed: "twStandard")
    public static let TWStandard = ChineseConverter.Options.twStandard
    
    @available(*, deprecated, renamed: "hkStandard")
    public static let HKStandard = ChineseConverter.Options.hkStandard
    
    @available(*, deprecated, renamed: "twIdiom")
    public static let TWIdiom = ChineseConverter.Options.twIdiom
}
