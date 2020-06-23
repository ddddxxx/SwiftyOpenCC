import XCTest
@testable import OpenCC

let targetRootURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
let projectRootURL = targetRootURL.deletingLastPathComponent().deletingLastPathComponent()

let dictionaryBundleURL = projectRootURL.appendingPathComponent("OpenCCDictionary.bundle")
let testCaseRootURL = targetRootURL.appendingPathComponent("testcases")
let testTextURL = targetRootURL.appendingPathComponent("benchmark/zuozhuan.txt")
let dictionaryBundle = Bundle(url: dictionaryBundleURL)!

let testCases: [(String, ChineseConverter.Options)] = [
    ("s2t", [.traditionalize]),
    ("t2s", [.simplify]),
    ("s2hk", [.traditionalize, .hkStandard]),
    ("hk2s", [.simplify, .hkStandard]),
    ("s2tw", [.traditionalize, .twStandard]),
    ("tw2s", [.simplify, .twStandard]),
    ("s2twp", [.traditionalize, .twStandard, .twIdiom]),
    ("tw2sp", [.simplify, .twStandard, .twIdiom]),
]

class OpenCCTests: XCTestCase {
    
    func converter(option: ChineseConverter.Options) throws -> ChineseConverter {
        return try ChineseConverter(bundle: dictionaryBundle, option: option)
    }
    
    func testConversion() throws {
        func testCase(name: String, ext: String) -> String {
            let url = testCaseRootURL.appendingPathComponent("\(name).\(ext)")
            return try! String(contentsOf: url)
        }
        for (name, opt) in testCases {
            let coverter = try ChineseConverter(bundle: dictionaryBundle, option: opt)
            let input = testCase(name: name, ext: "in")
            let converted = coverter.convert(input)
            let output = testCase(name: name, ext: "ans")
            XCTAssertEqual(converted, output, "Conversion \(name) fails")
        }
    }
    
    func testConverterCreationPerformance() {
        let options: ChineseConverter.Options = [.traditionalize, .twStandard, .twIdiom]
        measure {
            for _ in 0..<10 {
                _ = try! ChineseConverter(bundle: dictionaryBundle, option: options)
            }
        }
    }
    
    func testDictionaryCache() {
        let options: ChineseConverter.Options = [.traditionalize, .twStandard, .twIdiom]
        let holder = try! ChineseConverter(bundle: dictionaryBundle, option: options)
        measure {
            for _ in 0..<1_000 {
                _ = try! ChineseConverter(bundle: dictionaryBundle, option: options)
            }
        }
        _ = holder.convert("foo")
    }
    
    func testConversionPerformance() throws {
        let cov = try converter(option: [.traditionalize, .twStandard, .twIdiom])
        let str = try String(contentsOf: testTextURL)
        measure {
            _ = cov.convert(str)
        }
    }
    
    static var allTests = [
        ("testConversion", testConversion),
        ("testConverterCreationPerformance", testConverterCreationPerformance),
        ("testDictionaryCache", testDictionaryCache),
        ("testConversionPerformance", testConversionPerformance),
    ]
}
