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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let str = "忧郁的台湾乌龟"
        let converter = OpenCCConverter(option: [.traditionalize])
        converter.convert(str)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
