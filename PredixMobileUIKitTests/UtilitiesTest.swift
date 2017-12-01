//
//  UtilitiesTest.swift
//  PredixMobileUIKitTests
//
//  Created by Jeremy Osterhoudt on 10/31/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
@testable import PredixMobileUIKit

class UtilitiesTest: XCTestCase {
    func testShouldRunTheBlockOnTheRunningThread() {
        var x = 0
        let currentThread = Thread.current
        
        Utilities.runOnMainThread {
            x += 1
            XCTAssertEqual(currentThread, Thread.current)
        }
        
        XCTAssertEqual(1, x)
    }
    
    func testShouldRunBlockOnTheMainThread() {
        let expectation = self.expectation(description: "\(#function)")
        var x = 0
        
        DispatchQueue.global().async {
            Utilities.runOnMainThread {
                x += 1
                XCTAssertEqual(Thread.main, Thread.current)
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(1, x)
    }
}
