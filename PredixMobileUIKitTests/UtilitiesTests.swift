//
//  UtilitiesTests.swift
//  PredixMobileUIKitTests
//
//  Created by Johns, Andy (GE Corporate) on 10/13/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
@testable import PredixMobileUIKit

class UtilitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDegreesToRadians() {
        XCTAssertEqual(CGFloat.pi / 4, Utilities.radians(degrees: 45), accuracy: 0.001)
        XCTAssertEqual(CGFloat.pi / 3, Utilities.radians(degrees: 60), accuracy: 0.001)
        XCTAssertEqual(CGFloat.pi / 2, Utilities.radians(degrees: 90), accuracy: 0.001)
        XCTAssertEqual(CGFloat.pi, Utilities.radians(degrees: 180), accuracy: 0.001)
        XCTAssertEqual((CGFloat.pi * 3) / 2, Utilities.radians(degrees: 270), accuracy: 0.001)
        XCTAssertEqual(CGFloat.pi * 2, Utilities.radians(degrees: 360), accuracy: 0.001)
    }
    
    func testRadiansToDegrees() {
        XCTAssertEqual(45, Utilities.degrees(radians: CGFloat.pi / 4), accuracy: 0.001)
        XCTAssertEqual(60, Utilities.degrees(radians: CGFloat.pi / 3), accuracy: 0.001)
        XCTAssertEqual(90, Utilities.degrees(radians: CGFloat.pi / 2), accuracy: 0.001)
        XCTAssertEqual(180, Utilities.degrees(radians: CGFloat.pi), accuracy: 0.001)
        XCTAssertEqual(270, Utilities.degrees(radians: (CGFloat.pi * 3) / 2), accuracy: 0.001)
        XCTAssertEqual(360, Utilities.degrees(radians: CGFloat.pi * 2), accuracy: 0.001)
    }

}
