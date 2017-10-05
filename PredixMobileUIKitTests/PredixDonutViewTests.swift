//
//  PredixMobileUIKitTests.swift
//  PredixMobileUIKitTests
//
//  Created by Johns, Andy (GE Corporate) on 9/15/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
@testable import Charts
@testable import PredixMobileUIKit

class PredixDonutViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: IBInspectables
    // Test inspectable wrappers

    func testPrepareForInterfaceBuilder() {
        let donut = PredixDonutView()
        donut.prepareForInterfaceBuilder()
        // just ensure we created some data for now....
        XCTAssertTrue(donut.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")

    }

    func testSetLabelText() {
        let donut = PredixDonutView()
        let testString = "foobar"
        donut.labelText = testString
        XCTAssertEqual(testString, donut.chartDescription?.text, "chartDescription text did not match")
    }

    func testGetLabelText() {
        let donut = PredixDonutView()
        let testString = "foobar"
        donut.chartDescription?.text = testString
        XCTAssertEqual(testString, donut.labelText, "labelText did not match")
    }

    func testSetLabelEnabled() {
        let donut = PredixDonutView()
        let testValue = !(donut.chartDescription?.enabled ?? false)
        donut.labelEnabled = testValue
        XCTAssertEqual(testValue, donut.chartDescription?.enabled, "chartDescription enabled did not match")
    }

    func testGetLabelEnabled() {
        let donut = PredixDonutView()
        let testValue = !(donut.labelEnabled)
        donut.chartDescription?.enabled = testValue
        XCTAssertEqual(testValue, donut.labelEnabled, "labelEnabled did not match")
    }

    func testGetLabelEnabledNoLabel() {
        let donut = PredixDonutView()
        donut.chartDescription = nil
        XCTAssertFalse(donut.labelEnabled, "labelEnabled had unexpected value")
    }

    func testSetHoleRadius() {
        let donut = PredixDonutView()
        let testValue = 0.77
        donut.holeRadius = testValue
        XCTAssertEqual(testValue, donut.holeRadiusPercent.asDouble, accuracy: 0.001, "holeRadius did not match")
    }

    func testGetHoleRadius() {
        let donut = PredixDonutView()
        let testValue = CGFloat(0.77)
        donut.holeRadiusPercent = testValue
        XCTAssertEqual(testValue, donut.holeRadius.asCGFloat, accuracy: 0.001, "holeRadius did not match")
    }

    func testSetLegendHorizontalAlignment() {
        let donut = PredixDonutView()
        let testValue = Legend.HorizontalAlignment.center
        donut.legendHorizontalAlignment = testValue.rawValue
        XCTAssertEqual(testValue, donut.legend.horizontalAlignment, "Legend horizontalAlignment did not match")
    }

    func testGetLegendHorizontalAlignment() {
        let donut = PredixDonutView()
        let testValue = Legend.HorizontalAlignment.center
        donut.legend.horizontalAlignment = testValue
        XCTAssertEqual(testValue.rawValue, donut.legendHorizontalAlignment, "legendHorizontalAlignment did not match")
    }

    func testSetLegendVerticalAlignment() {
        let donut = PredixDonutView()
        let testValue = Legend.VerticalAlignment.center
        donut.legendVerticalAlignment = testValue.rawValue
        XCTAssertEqual(testValue, donut.legend.verticalAlignment, "Legend VerticalAlignment did not match")
    }

    func testGetLegendVerticalAlignment() {
        let donut = PredixDonutView()
        let testValue = Legend.VerticalAlignment.center
        donut.legend.verticalAlignment = testValue
        XCTAssertEqual(testValue.rawValue, donut.legendVerticalAlignment, "legendVerticalAlignment did not match")
    }

    func testSetLegendVerticalOrientation() {
        let donut = PredixDonutView()

        donut.legendVerticalOrientation = true
        XCTAssertEqual(Legend.Orientation.vertical, donut.legend.orientation, "Legend Orientation did not match")

        donut.legendVerticalOrientation = false
        XCTAssertEqual(Legend.Orientation.horizontal, donut.legend.orientation, "Legend Orientation did not match")
    }

    func testGetLegendVerticalOrientation() {
        let donut = PredixDonutView()

        donut.legend.orientation = .horizontal
        XCTAssertFalse(donut.legendVerticalOrientation, "legendVerticalOrientation had unexpected value")

        donut.legend.orientation = .vertical
        XCTAssertTrue(donut.legendVerticalOrientation, "legendVerticalOrientation had unexpected value")

    }

    func testSetLegendKeyOnLeft() {
        let donut = PredixDonutView()

        donut.legendKeyOnLeft = true
        XCTAssertEqual(Legend.Direction.leftToRight, donut.legend.direction, "Legend direction did not match")

        donut.legendKeyOnLeft = false
        XCTAssertEqual(Legend.Direction.rightToLeft, donut.legend.direction, "Legend direction did not match")
    }

    func testGetLegendKeyOnLeft() {
        let donut = PredixDonutView()

        donut.legend.direction = .rightToLeft
        XCTAssertFalse(donut.legendKeyOnLeft, "legendKeyOnLeft had unexpected value")

        donut.legend.direction = .leftToRight
        XCTAssertTrue(donut.legendKeyOnLeft, "legendKeyOnLeft had unexpected value")
    }

    func testSetLegendAllowOverlap() {
        let donut = PredixDonutView()

        let testValue = !donut.legend.drawInside
        donut.legendAllowOverlap = testValue

        XCTAssertEqual(testValue, donut.legend.drawInside, "Legend drawInside did not match")
    }

    func testGetLegendAllowOverlap() {
        let donut = PredixDonutView()

        let testValue = !donut.legend.drawInside
        donut.legend.drawInside = testValue

        XCTAssertEqual(testValue, donut.legendAllowOverlap, "legendAllowOverlap did not match")
    }

    // MARK: Test PredixDonutViewMethods

    func testInitWithCoder() {
        let donut = PredixDonutView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(donut)
        coder.finishEncoding()

        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newDonut = PredixDonutView(coder: decoder)
        XCTAssertNotNil(newDonut)
    }

    func testInitWithFrame() {
        // initialize with specific rect...
        let rect = CGRect(x: 0.1, y: 0.2, width: 0.3, height: 0.4)
        let donut = PredixDonutView(frame: rect)
        XCTAssertEqual(0.1, donut.frame.origin.x, accuracy: 0.01)
        XCTAssertEqual(0.2, donut.frame.origin.y, accuracy: 0.01)
        XCTAssertEqual(0.3, donut.frame.size.width, accuracy: 0.01)
        XCTAssertEqual(0.4, donut.frame.size.height, accuracy: 0.01)
    }

    func testloadLabelsAndValuesWithoutAnimation() {
        let donut = PredixDonutView()
        donut.renderer?.animator = TestAnimator(animateHandler: {
            XCTFail("Animation should not have been called")
        })

        let exampleValues: [String: Double] = [
            "IPA": 15,
            "Stout": 12,
            "Porter": 9,
            "Lambic": 8,
            "Pale Ale": 7,
            "Hefeweizen": 4,
            "Pilsner": 1,
            "Lager": 1
        ]
        donut.loadLabelsAndValues(exampleValues, showWithDefaultAnimation: false)
        // just ensure we created some data
        XCTAssertTrue(donut.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }

    func testloadLabelsAndValuesWithAnimation() {
        let expectation = self.expectation(description: #function)
        let donut = PredixDonutView()
        donut._animator = TestAnimator(animateHandler: {
            expectation.fulfill()
        })

        let exampleValues: [String: Double] = [
            "IPA": 15,
            "Stout": 12,
            "Porter": 9,
            "Lambic": 8,
            "Pale Ale": 7,
            "Hefeweizen": 4,
            "Pilsner": 1,
            "Lager": 1
        ]
        donut.loadLabelsAndValues(exampleValues)
        // just ensure we created some data
        XCTAssertTrue(donut.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testSDKVersion() {
        let donut = PredixDonutView()
        let versionInfo = donut.predixMobileSDKVersion()
        XCTAssertTrue(versionInfo.contains("pm sdk build version"), "No Predix version info")
    }
}

class TestAnimator: Animator {
    let animateHandler: () -> Void
    init(animateHandler: @escaping () -> Void) {
        self.animateHandler = animateHandler
        super.init()
    }
    open override func animate(xAxisDuration: TimeInterval, yAxisDuration: TimeInterval, easingX: ChartEasingFunctionBlock?, easingY: ChartEasingFunctionBlock?) {
        animateHandler()
    }

    open override func animate(xAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?) {
        animateHandler()
    }

    open override func animate(yAxisDuration: TimeInterval, easing: ChartEasingFunctionBlock?) {
        animateHandler()
    }
}
