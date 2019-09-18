import XCTest
@testable import OpenCC

let projectRootURL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

let dictionaryBundleURL = projectRootURL.appendingPathComponent("OpenCCDictionary.bundle")
let testCaseRootURL = projectRootURL.appendingPathComponent("TestResources/testcases")
let testTextURL = projectRootURL.appendingPathComponent("TestResources/孔乙己.txt")

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
            let i = testCase(name: name, ext: "in")
            let o = testCase(name: name, ext: "ans")
            XCTAssert(cov.convert(i) == o, "Conversion \(name) fails")
        }
    }
    
    func testConverterCreationPerformance() throws {
        measure {
            for (_, opt) in testCases {
                XCTAssertNoThrow({ _ = try self.converter(option: opt) })
            }
        }
    }
    
    func testConversionPerformance() throws {
        let testConverter = try converter(option: [.traditionalize, .TWStandard, .TWIdiom])
        // 2654 characters
        let testText = try String(contentsOf: testTextURL)
        measure {
            _ = testConverter.convert(testText)
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
    
    
    static var allTests = [
        ("testConversion", testConversion),
        ("testConverterCreationPerformance", testConverterCreationPerformance),
        ("testConversionPerformance", testConversionPerformance),
    ]
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
