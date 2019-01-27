//
//  Tests.swift
//  Tests
//
//  Created by 邓翔 on 2017/3/9.
//
//

import XCTest
@testable import OpenCC

class Tests: XCTestCase {
    
    func converter(option: ChineseConverter.Options) -> ChineseConverter {
        let url = Bundle.current.url(forResource: "OpenCCDictionary", withExtension: "bundle")!
        let bundle = Bundle(url: url)!
        return try! ChineseConverter(bundle: bundle, option: option)
    }
    
    func testConversion() {
        func testCase(name: String, ext: String) -> String {
            let url = Bundle.current.url(forResource: name, withExtension: ext, subdirectory: "testcases")!
            return try! String(contentsOf: url)
        }
        for (name, opt) in testCases {
            let cov = converter(option: opt)
            let i = testCase(name: name, ext: "in")
            let o = testCase(name: name, ext: "ans")
            XCTAssert(cov.convert(i) == o, "Conversion \(name) fails")
        }
    }
    
    func testConverterCreationPerformance() {
        self.measure {
            for (_, opt) in testCases {
                _ = converter(option: opt)
            }
        }
    }
    
    func testConversionPerformance() {
        let testConverter = converter(option: [.traditionalize, .TWStandard, .TWIdiom])
        self.measure {
            _ = testConverter.convert(self.testText)
        }
    }
    
    let testCases: [(String, ChineseConverter.Options)] = [
        ("s2t", [.traditionalize]),
        ("t2s", [.simplify]),
        ("s2hk", [.traditionalize, .HKStandard]),
        ("hk2s", [.simplify, .HKStandard]),
        ("s2tw", [.traditionalize, .TWStandard]),
        ("tw2s", [.simplify, .TWStandard]),
        ("s2twp", [.traditionalize, .TWStandard, .TWIdiom]),
        ("tw2sp", [.simplify, .TWStandard, .TWIdiom]),
    ]
    
    // 2654 characters
    let testText = try! String(contentsOf: Bundle.current.url(forResource: "孔乙己", withExtension: "txt")!)
}

extension Bundle {
    
    class var current: Bundle {
        let caller = Thread.callStackReturnAddresses[1]
        
        if let bundle = _cache.object(forKey: caller) {
            return bundle
        }
        
        var info = Dl_info(dli_fname: "", dli_fbase: nil, dli_sname: "", dli_saddr: nil)
        dladdr(caller.pointerValue, &info)
        let imagePath = String(cString: info.dli_fname)
        
        for bundle in Bundle.allBundles + Bundle.allFrameworks {
            if let execPath = bundle.executableURL?.resolvingSymlinksInPath().path,
                imagePath == execPath {
                _cache.setObject(bundle, forKey: caller)
                return bundle
            }
        }
        fatalError("Bundle not found for caller \"\(String(cString: info.dli_sname))\"")
    }
    
    private static let _cache = NSCache<NSNumber, Bundle>()
}
