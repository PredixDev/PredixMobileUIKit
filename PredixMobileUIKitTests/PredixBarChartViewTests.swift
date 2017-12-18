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

    // MARK: IBInspectables

    // MARK: label text tests

    func testSetLabelText() {
        let barChart = PredixBarChartView()
        let testString = "foo"
        barChart.labelText = testString
        XCTAssertEqual(testString, barChart.chartDescription?.text, "chartDescription text did not match")
    }

    func testSetLabelEnabled() {
        let barChart = PredixBarChartView()
        let testValue = !(barChart.chartDescription?.enabled ?? false)
        barChart.labelEnabled = testValue
        XCTAssertEqual(testValue, barChart.chartDescription?.enabled, "chartDescription enabled did not match")
    }

    func testGetLabelEnabled() {
        let barChart = PredixBarChartView()
        let testValue = !(barChart.labelEnabled)
        barChart.chartDescription?.enabled = testValue
        XCTAssertEqual(testValue, barChart.labelEnabled, "labelEnabled did not match")
    }

    // MARK: No data message tests

    func testSetNoDataMessage() {
        let barChart = PredixBarChartView()
        let testString = "bar"
        barChart.noDataMessage = testString
        XCTAssertEqual(testString, barChart.noDataText)
    }

    func testGetNoDataMessage() {
        let barChart = PredixBarChartView()
        let testString = "foo"
        barChart.noDataText = testString
        XCTAssertEqual(testString, barChart.noDataMessage)
    }

    // MARK: Legend orientation tests

    func testSetLegendVerticalOrientation() {
        let barChart = PredixBarChartView()
        barChart.legendOrientationVertical = true
        XCTAssertEqual(Legend.Orientation.vertical, barChart.legend.orientation, "Legend Orientation did not match")

        barChart.legendOrientationVertical = false
        XCTAssertEqual(Legend.Orientation.horizontal, barChart.legend.orientation, "Legend Orientation did not match")
    }

    func testGetLegendVerticalOrientation() {
        let barChart = PredixBarChartView()

        barChart.legend.orientation = .horizontal
        XCTAssertFalse(barChart.legendOrientationVertical, "legendVerticalOrientation had unexpected value")

        barChart.legend.orientation = .vertical
        XCTAssertTrue(barChart.legendOrientationVertical, "legendVerticalOrientation had unexpected value")
    }

    // MARK: Legend alignment

    func testSetLegendAlignedLeft() {
        let barChart = PredixBarChartView()
        barChart.legend.horizontalAlignment = .left
        XCTAssertEqual(barChart.legend.horizontalAlignment, .left, "Legend should be aligned to left")
    }

    func testGetLegendAlignedLeft() {
        let barChart = PredixBarChartView()
        barChart.legend.horizontalAlignment = .left
        XCTAssertTrue(barChart.legendAlignedLeft, "Legend should be aligned to left")
    }

    func testSetLegendAlignedLeftAssignedToRight() {
        let barChart = PredixBarChartView()
        barChart.legendAlignedLeft = false
        XCTAssertEqual(barChart.legend.horizontalAlignment, .right, "Legend should be aligned to right")
    }

    func testSetLegendAlignedBottom() {
        let barChart = PredixBarChartView()
        barChart.legendAlignedOnBottom = true
        XCTAssertEqual(barChart.legend.verticalAlignment, .bottom, "Legend should be aligned to top")
    }

    func testGetLegendAlignedBottom() {
        let barChart = PredixBarChartView()
        barChart.legend.verticalAlignment = .bottom
        XCTAssertTrue(barChart.legendAlignedOnBottom, "Legend should be aligned on the  bottom")
    }

    func testSetLegendAlignedBottomAssignedAsTop() {
        let barChart = PredixBarChartView()
        barChart.legendAlignedOnBottom = false
        XCTAssertEqual(barChart.legend.verticalAlignment, .top, "Legend should be aligned to bottom")
    }

    // MARK: Chart Border Color tests

    func testSetCharBorderColor() {
        let barChart = PredixBarChartView()
        barChart.chartBorderColor = .red
        XCTAssertEqual(UIColor.red, barChart.borderColor, "Chart Border Color should be red")
    }

    func testGetChartBorderColor() {
        let barChart = PredixBarChartView()
        barChart.borderColor = .red
        XCTAssertEqual(UIColor.red, barChart.chartBorderColor, "Chart Border Color should be red")
    }

    // MARK: Chart x axis text color test

    func testSetxAxisTextColor() {
        let barChart = PredixBarChartView()
        barChart.xAxisTextColor = .red
        XCTAssertEqual(UIColor.red, barChart.xAxis.labelTextColor, "Chart x axis should be red")
    }

    func testGetAxisTextColor() {
        let barChart = PredixBarChartView()
        barChart.xAxis.labelTextColor = .red
        XCTAssertEqual(UIColor.red, barChart.xAxisTextColor, "Chart x axis should be red")
    }

    // MARK: legend text color tests

    func testSetLegendTexColor() {
        let barChart = PredixBarChartView()
        barChart.legend.textColor = .red
        XCTAssertEqual(UIColor.red, barChart.legendTextColor, "Legend text color should be red")
    }

    func testGetLegendTextColor() {
        let barChart = PredixBarChartView()
        barChart.legendTextColor = .red
        XCTAssertEqual(UIColor.red, barChart.legend.textColor, "Legend text color should be red")
    }

    // MARK: No chart data text color tests

    func testSetNoChartDataTextColor() {
        let barChart = PredixBarChartView()
        barChart.noDataTextColor = .red
        XCTAssertEqual(UIColor.red, barChart.noChartDataTextColor, "No chart data text color red")
    }

    func testGetNoChartDataTextColor() {
        let barChart = PredixBarChartView()
        barChart.noChartDataTextColor = .red
        XCTAssertEqual(UIColor.red, barChart.noDataTextColor, "No chart data text color red")
    }

    // MARK: Test PredixBarCharViewMethods

    func testInitWithCoder() {
        let barChart = PredixBarChartView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(barChart)
        coder.finishEncoding()

        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newBarChart = PredixDonutView(coder: decoder)
        XCTAssertNotNil(newBarChart)
    }

    func testInitWithFrame() {
        let rect = CGRect(x: 0.0, y: 0.0, width: 0.6, height: 0.4)
        let barChart = PredixBarChartView(frame: rect)
        XCTAssertEqual(0.0, barChart.frame.origin.x, accuracy: 0.01)
        XCTAssertEqual(0.0, barChart.frame.origin.y, accuracy: 0.01)
        XCTAssertEqual(0.6, barChart.frame.size.width, accuracy: 0.01)
        XCTAssertEqual(0.4, barChart.frame.size.height, accuracy: 0.01)
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
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        let bar2 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.red])

        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
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
        let barChart1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        let barChart2 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.red])

        barChart.create(xAxisValues: months, bars: [barChart1, barChart2], showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
        waitForExpectations(timeout: 1, handler: nil)
    }
}
