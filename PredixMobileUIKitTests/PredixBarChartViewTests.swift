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
    
    func testSetLabelText(){
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
    
    
    func testSetLegendHorizontalAlignment() {
        let barChart = PredixBarChartView()
        let testValue = Legend.HorizontalAlignment.center
        barChart.legendHorizontalAlignment = testValue.rawValue
        XCTAssertEqual(testValue, barChart.legend.horizontalAlignment, "Legend horizontalAlignment did not match")
    }
    
    func testGetLegendHorizontalAlignment() {
        let barChart = PredixBarChartView()
        let testValue = Legend.HorizontalAlignment.center
        barChart.legend.horizontalAlignment = testValue
        XCTAssertEqual(testValue.rawValue, barChart.legendHorizontalAlignment, "legendHorizontalAlignment did not match")
    }
    
    
    func testSetLegendVerticalAlignment() {
        let barChart = PredixBarChartView()
        let testValue = Legend.VerticalAlignment.center
        barChart.legendVerticalAlignment = testValue.rawValue
        XCTAssertEqual(testValue, barChart.legend.verticalAlignment, "Legend VerticalAlignment did not match")
    }
    
    
    func testGetLegendVerticalAlignment() {
        let barChart = PredixBarChartView()
        let testValue = Legend.VerticalAlignment.center
        barChart.legend.verticalAlignment = testValue
        XCTAssertEqual(testValue.rawValue, barChart.legendVerticalAlignment, "legendVerticalAlignment did not match")
    }
    
    func testSetLegendVerticalOrientation() {
        let barChart = PredixBarChartView()
        barChart.legendVerticalOrientation = true
        XCTAssertEqual(Legend.Orientation.vertical, barChart.legend.orientation, "Legend Orientation did not match")
        
        barChart.legendVerticalOrientation = false
        XCTAssertEqual(Legend.Orientation.horizontal, barChart.legend.orientation, "Legend Orientation did not match")
    }
    
    func testSetXAxisLabelsPosition(){
        let barChart = PredixBarChartView()
        let  testValue = XAxis.LabelPosition.bottom
        barChart.xAxisLabelPosition = testValue.rawValue
        XCTAssertEqual(testValue, barChart.xAxis.labelPosition, "X Axis label Position did not match")
    }
    
    func testGetXAXisLabelsPosition(){
        let barChart = PredixBarChartView()
        let testValue = XAxis.LabelPosition.bothSided
        barChart.xAxis.labelPosition = testValue
        XCTAssertEqual(testValue.rawValue, barChart.xAxisLabelPosition, "x Axis label position had unexpected value")
        
    }
    
    func testGetLegendVerticalOrientation() {
        let barChart = PredixBarChartView()
        
        barChart.legend.orientation = .horizontal
        XCTAssertFalse(barChart.legendVerticalOrientation, "legendVerticalOrientation had unexpected value")
        
        barChart.legend.orientation = .vertical
        XCTAssertTrue(barChart.legendVerticalOrientation, "legendVerticalOrientation had unexpected value")
        
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
