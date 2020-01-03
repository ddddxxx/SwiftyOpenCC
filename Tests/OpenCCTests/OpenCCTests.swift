import XCTest
@testable import OpenCC

let projectRootURL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

let dictionaryBundleURL = projectRootURL.appendingPathComponent("OpenCCDictionary.bundle")
let testCaseRootURL = projectRootURL.appendingPathComponent("TestResources/testcases")
let testTextURL = projectRootURL.appendingPathComponent("TestResources/孔乙己.txt")

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
        let bundle = Bundle(url: dictionaryBundleURL)!
        return try ChineseConverter(bundle: bundle, option: option)
    }
    
    func testConversion() throws {
        func testCase(name: String, ext: String) -> String {
            let url = testCaseRootURL.appendingPathComponent("\(name).\(ext)")
            return try! String(contentsOf: url)
        }
        for (name, opt) in testCases {
            let cov = try converter(option: opt)
            let input = testCase(name: name, ext: "in")
            let output = testCase(name: name, ext: "ans")
            XCTAssert(cov.convert(input) == output, "Conversion \(name) fails")
        }
    }
    
    func testConverterCreationPerformance() {
        measure {
            for (_, opt) in testCases {
                XCTAssertNoThrow({ _ = try self.converter(option: opt) })
            }
        }
    }
    
    func testConversionPerformance() throws {
        let cov = try converter(option: [.traditionalize, .twStandard, .twIdiom])
        // 2654 characters
        let str = try String(contentsOf: testTextURL)
        measure {
            _ = cov.convert(str)
        }
    }
    
    static var allTests = [
        ("testConversion", testConversion),
        ("testConverterCreationPerformance", testConverterCreationPerformance),
        ("testConversionPerformance", testConversionPerformance),
    ]
}
