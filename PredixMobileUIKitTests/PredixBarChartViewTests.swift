//
//  PredixBarChartViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by Fouche, George (GE Healthcare) on 12/4/17.
//  Copyright © 2017 GE. All rights reserved.
//

@testable import Charts
@testable import PredixMobileUIKit
import XCTest

class PredixBarChartViewTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadChartWithAnimation() {
        let expectation = self.expectation(description: #function)
        let barChart = PredixBarChartView()

        barChart._animator = TestAnimator(animateHandler: {
            expectation.fulfill()
        })

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        barChart.loadChart(xValues: months, yValues: unitsSold, label: "Units Sold", showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testloadAndStackChartWithAnimation() {
        let expectation = self.expectation(description: #function)
        let barChart = PredixBarChartView()

        barChart._animator = TestAnimator(animateHandler: {
            expectation.fulfill()
        })

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]
        barChart.loadAndStackChart(xValues: months, yValues1AndyValue2: (unitsSold, unitsBought), label1AndLabel2: ("Units Sold", "Units Bought"), uiColor1AnduiColor2: ([NSUIColor.red], [NSUIColor.blue]), showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testloadAndStackChartWithNoAnimation() {
        let barChart = PredixBarChartView()

        barChart.renderer?.animator = TestAnimator(animateHandler: {
            XCTFail("Animation should not have been called")
        })

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]
        barChart.loadAndStackChart(xValues: months, yValues1AndyValue2: (unitsSold, unitsBought), label1AndLabel2: ("Units Sold", "Units Bought"), uiColor1AnduiColor2: ([NSUIColor.red], [NSUIColor.blue]), showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }

    func testLoadChartWithNoAnimation() {
        let barChart = PredixBarChartView()

        barChart.renderer?.animator = TestAnimator(animateHandler: {
            XCTFail("Animation should not have been called")
        })

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        barChart.loadChart(xValues: months, yValues: unitsSold, label: "Units Sold", showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }
}
