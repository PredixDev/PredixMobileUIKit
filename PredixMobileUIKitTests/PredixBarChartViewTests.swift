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

    var months: [String] = []
    var unitsSold: [Double] = []
    var unitsBought: [Double] = []
    var bar1: Bar!
    var bar2: Bar!

    override func setUp() {
        super.setUp()

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]
        bar1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        bar2 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.red])
    }

    override func tearDown() {
        super.tearDown()
        months.removeAll()
        unitsSold.removeAll()
        unitsBought.removeAll()
    }

    // MARK: IBInspectables

    // MARK: Label Text Test Cases

    func testSetLabelText() {
        let barChart = PredixBarChartView()
        let testString = "foo"
        barChart.labelText = testString
        XCTAssertEqual(testString, barChart.chartDescription?.text, "chartDescription text did not match")
    }

    func testGetLabelText() {
        let barChart = PredixBarChartView()
        let testString = "foo"
        barChart.chartDescription?.text = testString
        XCTAssertEqual(testString, barChart.labelText, "chartDescription text did not match")
    }

    func testSetLabelEnabled() {
        let barChart = PredixBarChartView()
        barChart.labelEnabled = true
        XCTAssertTrue(barChart.chartDescription?.enabled ?? false, "Chart description should be enabled.")
    }

    func testGetLabelEnabled() {
        let barChart = PredixBarChartView()
        barChart.chartDescription?.enabled = true
        XCTAssertTrue(barChart.labelEnabled, "Chart description should be enabled now.")
    }

    func testLabelEnabledReturnsFalseWhenTheChartDescriptionIsNil() {
        let barChart = PredixBarChartView(frame: CGRect())
        barChart.chartDescription = nil
        XCTAssertFalse(barChart.labelEnabled)
    }

    // MARK: No Data Message Test Cases

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

    // MARK: Legend Orientation Test Cases

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

    // MARK: Legend Alignment Test Cases

    func testSetLegendAlignedLeft() {
        let barChart = PredixBarChartView()
        barChart.legendAlignedLeft = true
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

    // MARK: Chart Border Color test Cases

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

    // MARK: Chart X Axis Text Color Test Cases

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

    // MARK: Legend Text Color Test Cases

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

    // MARK: No Chart Data Text Color Test Cases

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

    // MARK: PredixBarCharViewMethods

    func testInitWithCoder() {
        let barChart = PredixBarChartView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(barChart)
        coder.finishEncoding()

        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newBarChart = PredixBarChartView(coder: decoder)
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

    // MARK: PredixBarCharView HandleOptionMethods

    func testHandleOptionEnableLegend() {
        let barChart = PredixBarChartView()
        barChart.handleOption(.enableLegend)
        XCTAssertEqual(barChart.legend.enabled, true, "Option enableLegend should be true")
    }

    func testHandleOptionDisableLegend() {
        let barChart = PredixBarChartView()
        barChart.handleOption(.disableLegend)
        XCTAssertEqual(barChart.legend.enabled, false, "Option disableLegend should be false")
    }

    func testHandleOptionDisableSideLabels() {
        let barChart = PredixBarChartView()
        barChart.handleOption(.disableSideLabels)
        XCTAssertEqual(barChart.rightAxis.drawLabelsEnabled, false, "Right Axis drawLabelsEnabled should be false")
        XCTAssertEqual(barChart.leftAxis.drawLabelsEnabled, false, "Left Axis drawLabelsEnabled should be false")
    }

    func testHandleOptionEnableSideLabels() {
        let barChart = PredixBarChartView()
        barChart.handleOption(.enableSideLabels)
        XCTAssertEqual(barChart.rightAxis.drawLabelsEnabled, true, "Right Axis drawLabelsEnabled should be true")
        XCTAssertEqual(barChart.leftAxis.drawLabelsEnabled, true, "Left Axis drawLabelsEnabled should be true")
    }

    func testHandleOptionToggleValues() {
        let barChart = PredixBarChartView()
        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        let bar2 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.red])

        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")

        barChart.handleOption(.toggleValues)
        XCTAssertEqual(barChart.data?._dataSets[0].drawValuesEnabled, false, "Value on a the first data set should be set to false")

        barChart.handleOption(.toggleValues)
        XCTAssertEqual(barChart.data?._dataSets[0].drawValuesEnabled, true, "Value on a the first data set should be set to true")
    }

    func testHandleOptionToggleBarBorders() {
        let barChart = PredixBarChartView()
        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded")

        barChart.handleOption(.toggleBarBorders)

        for set in barChart.data!.dataSets {
            let get = set as? BarChartDataSet
            XCTAssertEqual(get?.barBorderWidth, 1.0, "Each bar border should be 1.0 ")
        }
    }

    func testHandleOptionAnimateXY() {
        let animateXY = "XY"
        let barChart = PredixBarChartView()
        let expectation = self.expectation(description: #function)
        barChart._animator = TestPredixBarChartViewAnimator(animateHandler: {
            expectation.fulfill()
        })

        barChart.handleOption(.animateXY)
        XCTAssertEqual(barChart._animator.debugDescription, animateXY)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testHandleOptionAnimateX() {
        let animateX = "X"
        let barChart = PredixBarChartView()
        let expectation = self.expectation(description: #function)
        barChart._animator = TestPredixBarChartViewAnimator(animateHandler: {
            expectation.fulfill()
        })

        barChart.handleOption(.animateX)
        XCTAssertEqual(barChart._animator.debugDescription, animateX)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testHandleOptionAnimateY() {
        let animateY = "Y"
        let barChart = PredixBarChartView()
        let expectation = self.expectation(description: #function)
        barChart._animator = TestPredixBarChartViewAnimator(animateHandler: {
            expectation.fulfill()

        })

        barChart.handleOption(.animateY)
        XCTAssertEqual(barChart._animator.debugDescription, animateY)
        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK: PredixBarCharView Adding Displaying and Removing the Limit Line on the chart test cases

    func testAddALimit() {
        let barChart = PredixBarChartView()
        barChart.addALimit(limit: 10.0, label: "LineLabel")
        let limitLines = barChart.rightAxis.limitLines
        XCTAssertEqual(limitLines.count, 1, "One Limit lines should be created")
    }

    func testRemoveALimit() {
        let barChart = PredixBarChartView()
        barChart.addALimit(limit: 10.0, label: "LineLabel")
        var limitLines = barChart.rightAxis.limitLines
        XCTAssertEqual(limitLines.count, 1, "One Limit lines should be created")
        barChart.removeLimit()
        limitLines = barChart.rightAxis.limitLines
        XCTAssertEqual(limitLines.count, 0, "All Limit lines should be removed")
    }

    func testDisplayLimit() {
        let barChart = PredixBarChartView()
        barChart.displayLimitLine(true)
        var limitLines = barChart.rightAxis.limitLines
        XCTAssertEqual(limitLines.count, 1, "One Limit lines should be created")
        barChart.displayLimitLine(false)
        limitLines = barChart.rightAxis.limitLines
        XCTAssertEqual(limitLines.count, 0, "All Limit lines should be removed")
    }

    // MARK: PredixBarCharView Creation of the chart test cases

    func testCreateChartWithAnimation() {
        let expectation = self.expectation(description: #function)
        let barChart = PredixBarChartView()

        barChart._animator = TestPredixBarChartViewAnimator(animateHandler: {
            expectation.fulfill()
        })

        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded")
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCreateChartByProvidingBarColors() {

        let barChart = PredixBarChartView()

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        let bar2 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.red])
        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
        let colors = barChart.barData?.getColors()
        XCTAssertEqual([NSUIColor.blue, NSUIColor.red], colors!)
    }

    func testCreateChartByNotProvidingBarColors() {
        let defautColor = NSUIColor.gray
        let barChart = PredixBarChartView()

        var months: [String]!
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.blue])
        let bar2 = Bar(unitsBought, label: "Units Bought")
        barChart.create(xAxisValues: months, bars: [bar1, bar2], showWithDefaultAnimation: true)
        let colors = barChart.barData?.getColors()
        XCTAssertEqual([NSUIColor.blue, defautColor], colors!)
    }

    func testloadAndStackChartWithAnimation() {
        let expectation = self.expectation(description: #function)
        let barChart = PredixBarChartView()

        barChart._animator = TestPredixBarChartViewAnimator(animateHandler: {
            expectation.fulfill()
        })

        barChart.create(xAxisValues: months, bars: [bar1, bar2], stackBars: false, showWithDefaultAnimation: true)
        XCTAssertTrue(barChart.data?.dataSetCount ?? 0 > 0, "No datasets were loaded")
        waitForExpectations(timeout: 1, handler: nil)
    }

    class TestPredixBarChartViewAnimator: Animator {
        let animateHandler: () -> Void
        var whatAnimateMI = "none"

        init(animateHandler: @escaping () -> Void) {
            self.animateHandler = animateHandler
            super.init()
        }

        open override func animate(xAxisDuration _: TimeInterval, yAxisDuration _: TimeInterval, easingX _: ChartEasingFunctionBlock?, easingY _: ChartEasingFunctionBlock?) {
            animateHandler()
            whatAnimateMI = "XY"
        }

        open override func animate(xAxisDuration _: TimeInterval, easing _: ChartEasingFunctionBlock?) {
            animateHandler()
            whatAnimateMI = "X"
        }

        open override func animate(yAxisDuration _: TimeInterval, easing _: ChartEasingFunctionBlock?) {
            animateHandler()
            whatAnimateMI = "Y"
        }

        override var debugDescription: String {
            return whatAnimateMI
        }
    }
}
