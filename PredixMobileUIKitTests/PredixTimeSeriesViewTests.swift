//
//  PredixTimeSeriesViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by 212460388 on 10/2/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest

@testable import Charts
@testable import PredixMobileUIKit
@testable import PredixSDK

class PredixTimeSeriesViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: PredixTimeSeriesView IBInspectables test
    
    func testPrepareForInterfaceBuilderShouldInitializeWithDummyData() {
        let tsView = PredixTimeSeriesView()
        tsView.prepareForInterfaceBuilder()
        XCTAssertTrue(tsView.data?.dataSetCount ?? 0 > 0, "PrepareForInterfaceBuilder should initialize dummy data")
    }
    
    func testSetLabelText() {
        let tsView = PredixTimeSeriesView()
        let testString = "SomeNewText"
        tsView.labelText = testString
        XCTAssertEqual(testString, tsView.chartDescription?.text, "Chart description text should match.")
    }
    
    func testGetLabelText() {
        let tsView = PredixTimeSeriesView()
        let testString = "SomeNewText"
        tsView.chartDescription?.text = testString
        XCTAssertEqual(testString, tsView.labelText, "Chart description text should match.")
    }
    
    func testSetLabelEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.labelEnabled = true
        XCTAssertTrue(tsView.chartDescription?.enabled ?? false, "Chart description should be enabled.")
    }
    
    func testGetLabelEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.chartDescription?.enabled = true
        XCTAssertTrue(tsView.labelEnabled, "Chart description should be enabled now.")
    }
    
    func testSetLegendVerticalOrientation() {
        let tsView = PredixTimeSeriesView()
        tsView.legendVerticalOrientation = true
        XCTAssertEqual(tsView.legend.orientation, .vertical, "Should be orineted vertically")
    }
    
    func testSetLegendVerticalOrientationAsHorizontal() {
        let tsView = PredixTimeSeriesView()
        tsView.legendVerticalOrientation = false
        XCTAssertEqual(tsView.legend.orientation, .horizontal, "Should be orineted horizontally")
    }
    
    func testGetLegendVerticalOrientation() {
        let tsView = PredixTimeSeriesView()
        tsView.legend.orientation = .vertical
        XCTAssertTrue(tsView.legendVerticalOrientation, "Should be orineted vertically")
    }
    
    func testSetLeftAxisEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.leftAxisEnabled = true
        XCTAssertTrue(tsView.leftAxis.enabled, "Left axis should be enabled")
    }
    
    func testGetLeftAxisEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.leftAxis.enabled = true
        XCTAssertTrue(tsView.leftAxisEnabled, "Left axis should be enabled")
    }
    
    func testSetRightAxisEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.rightAxisEnabled = true
        XCTAssertTrue(tsView.rightAxis.enabled, "Right axis should be enabled")
    }
    
    func testGetRightAxisEnabled() {
        let tsView = PredixTimeSeriesView()
        tsView.rightAxis.enabled = true
        XCTAssertTrue(tsView.rightAxisEnabled, "Right axis should be enabled")
    }
    
    func testSetLegendAlignedLeft() {
        let tsView = PredixTimeSeriesView()
        tsView.legendAlignedLeft = true
        XCTAssertEqual(tsView.legend.horizontalAlignment, .left, "Legend should be aligned to left")
    }
    
    func testSetLegendAlignedLeftAssignedToRight() {
        let tsView = PredixTimeSeriesView()
        tsView.legendAlignedLeft = false
        XCTAssertEqual(tsView.legend.horizontalAlignment, .right, "Legend should be aligned to Right")
    }
    
    func testGetLegendAlignedLeft() {
        let tsView = PredixTimeSeriesView()
        tsView.legend.horizontalAlignment = .left
        XCTAssertTrue(tsView.legendAlignedLeft, "Legend should be aligned to left")
    }
    
    func testSetLegendAlignedTop() {
        let tsView = PredixTimeSeriesView()
        tsView.legendAlignedTop = true
        XCTAssertEqual(tsView.legend.verticalAlignment, .top, "Legend should be aligned to top")
    }
    
    func testSetLegendAlignedTopAssignedAsBottom() {
        let tsView = PredixTimeSeriesView()
        tsView.legendAlignedTop = false
        XCTAssertEqual(tsView.legend.verticalAlignment, .bottom, "Legend should be aligned to bottom")
    }
    
    func testGetLegendAlignedTop() {
        let tsView = PredixTimeSeriesView()
        tsView.legend.verticalAlignment = .top
        XCTAssertTrue(tsView.legendAlignedTop, "Legend should be aligned to top")
    }
    
    func testInitWithCoder() {
        let tsView = PredixTimeSeriesView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(tsView)
        coder.finishEncoding()
        
        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newTSView = PredixTimeSeriesView(coder: decoder)
        XCTAssertNotNil(newTSView)
    }
    
    func testtestInitWithFrame() {
        let rect = CGRect(x: 0.1, y: 0.2, width: 0.3, height: 0.4)
        let tsView = PredixTimeSeriesView(frame: rect)
        XCTAssertEqual(tsView.frame.origin.x, rect.minX, accuracy: 0.01)
        XCTAssertEqual(tsView.frame.origin.y, rect.minY, accuracy: 0.01)
        XCTAssertEqual(tsView.frame.size.width, rect.width, accuracy: 0.01)
        XCTAssertEqual(tsView.frame.size.height, rect.height, accuracy: 0.01)
    }
    
    func testloadLabelsAndValues() {
        let tsView = PredixTimeSeriesView()
        tsView.load(dataSets: generateDummyData())
        XCTAssertTrue(tsView.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }
    
    func testLayoutSubViewsSetsTheBoundsOnTheGrayViewAndActivityView() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.bounds = CGRect(x: 5, y: 1, width: 44, height: 1044)
        view.layoutSubviews()
        
        XCTAssertEqual(view.bounds, view.grayView.frame)
        XCTAssertEqual(view.bounds, view.activityView.frame)
    }
    
    func testTheGrayViewAndActivityViewHaveTheCorrectAutoResizeMask() {
        let view = PredixTimeSeriesView(frame: CGRect())
        let expectedMask: UIView.AutoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        XCTAssertEqual(expectedMask, view.grayView.autoresizingMask)
        XCTAssertEqual(expectedMask, view.activityView.autoresizingMask)
    }
    
    func testLabelEnabledReturnsFalseWhenTheChartDiscriptionIsNil() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.chartDescription = nil
        XCTAssertFalse(view.labelEnabled)
    }
    
    func testTheDataPointFontIsTheSystemFontAndSizeByDefault() {
        let view = PredixTimeSeriesView(frame: CGRect())
        let expectedFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        XCTAssertEqual(expectedFont, view.dataPointFont)
    }
    
    func testTheChartBoarderColorReturnsTheBoarderColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.borderColor = .red
        
        XCTAssertEqual(UIColor.red, view.chartBorderColor)
    }
    
    func testSettingTheChartBoarderColorSetsTheBoarderColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.chartBorderColor = .red
        
        XCTAssertEqual(UIColor.red, view.borderColor)
    }
    
    func testSettingTheXAxisTextColorSetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.xAxisTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.xAxis.labelTextColor)
    }
    
    func testGettingTheXAxisTextColorGetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.xAxis.labelTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.xAxisTextColor)
    }
    
    func testSettingTheRightAxisTextColorTextColorSetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.rightAxisTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.rightAxis.labelTextColor)
    }
    
    func testGettingTheRightAxisTextColorTextColorGetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.rightAxis.labelTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.rightAxisTextColor)
    }
    
    func testSettingTheLeftAxisTextColorTextColorSetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.leftAxisTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.leftAxis.labelTextColor)
    }
    
    func testGettingTheLeftAxisTextColorTextColorGetsTheXAxisLabelTextColor() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.leftAxis.labelTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.leftAxisTextColor)
    }
    
    func testTheLegendTextColorReturnsTheLegendColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.legend.textColor = .red
        
        XCTAssertEqual(UIColor.red, view.legendTextColor)
    }
    
    func testSettingTheLegendTextColorSetsTheLegendColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.legendTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.legend.textColor)
    }
    
    func testTheNoDataColorReturnsTheNoDataTextColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.noDataTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.noChartDataTextColor)
    }
    
    func testSettingTheNoDataColorSetsTheNoDataTextColorFromTheChartsLibrary() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.noChartDataTextColor = .red
        
        XCTAssertEqual(UIColor.red, view.noDataTextColor)
    }
    
    func testSettingDarkThemeToTrueSetsTheProperColors() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.darkTheme = true
        
        XCTAssertEqual(UIColor(hue: 51.0/255.0, saturation: 51.0/255.0, brightness: 51.0/255.0, alpha: 1.0), view.backgroundColor)
        XCTAssertEqual(UIColor.white, view.chartBorderColor)
        XCTAssertEqual(UIColor.white, view.xAxisTextColor)
        XCTAssertEqual(UIColor.white, view.rightAxisTextColor)
        XCTAssertEqual(UIColor.white, view.leftAxisTextColor)
        XCTAssertEqual(UIColor.white, view.legendTextColor)
        XCTAssertEqual(UIColor.white, view.noChartDataTextColor)
    }
    
    func testSettingDarkThemeToFalseSetsTheProperColors() {
        let view = PredixTimeSeriesView(frame: CGRect())
        view.darkTheme = false
        
        XCTAssertEqual(UIColor.clear, view.backgroundColor)
        XCTAssertEqual(UIColor.black, view.chartBorderColor)
        XCTAssertEqual(UIColor.black, view.xAxisTextColor)
        XCTAssertEqual(UIColor.black, view.rightAxisTextColor)
        XCTAssertEqual(UIColor.black, view.leftAxisTextColor)
        XCTAssertEqual(UIColor.black, view.legendTextColor)
        XCTAssertEqual(UIColor.black, view.noChartDataTextColor)
    }
    
    func testSettingThePredixTimeSeriesViewDelegateWithLoadTimeSeriesTagsDefinedLoadsDataIntoTheChart() {
        let delegate = RawDataTimeSeriesViewDelegate()
        let dataSet = LineChartDataSet(values: [ChartDataEntry(x: 1, y: 2)], label: "MyData")
        
        let view = PredixTimeSeriesView(frame: CGRect())
        view.load(dataSets: [dataSet])
        view.timeSeriesDataDelegate = delegate
        
        let chartData = view.data?.dataSets.first?.entryForIndex(0)
        
        XCTAssertEqual(1.0, chartData?.x)
        XCTAssertEqual(2.0, chartData?.y)
    }
    
    func testTheSelectedGraphValueIsToldToTheDelegate() {
        let delegate = RawDataTimeSeriesViewDelegate()
        let dataSet = LineChartDataSet(values: [ChartDataEntry(x: 1, y: 2)], label: "MyData")
        
        let view = PredixTimeSeriesView(frame: CGRect())
        view.load(dataSets: [dataSet])
        view.timeSeriesDataDelegate = delegate
        view.highlightValue(x: 1, dataSetIndex: 0)
        
        XCTAssertEqual(1.0, delegate.selectedTimeScale)
    }
    
    func testLoadingChartDataUsingTheSDKTagDataPointModel() {
        let groups = [["name": "aName", "type": "aType", "value": 1]]
        let values = [1, 2, 3]
        let dataPoint = TagDataPoint(json: ["name": "MyTag", "results": [["groups": groups, "values": [values]]]])
        
        let view = PredixTimeSeriesView(frame: CGRect())
        view.load(tagDataPoints: [dataPoint])
        let dataSet = view.data?.dataSets.first
        let chartData = dataSet?.entryForIndex(0)
        
        XCTAssertEqual("MyTag", dataSet?.label)
        XCTAssertEqual(1, dataSet?.entryCount ?? 0)
        XCTAssertEqual(1, chartData?.x)
        XCTAssertEqual(2, chartData?.y)
        XCTAssertEqual(3, chartData?.data as? Int ?? 0)
    }
    
    func testLoadingChartDataUsingTheSDKDataPointResponseModel() {
        let groups = [["name": "aName", "type": "aType", "value": 1]]
        let values = [1, 2, 3]
        let tags = [["name": "MyTag", "results": [["groups": groups, "values": [values]]]]]
        let dataPointResponse = DataPointResponse(json: ["stats": ["rawCount": 1], "tags": tags] as [String: Any])
        
        let view = PredixTimeSeriesView(frame: CGRect())
        view.load(dataPointResponse: dataPointResponse)
        let dataSet = view.data?.dataSets.first
        let chartData = dataSet?.entryForIndex(0)
        
        XCTAssertEqual("MyTag", dataSet?.label)
        XCTAssertEqual(1, dataSet?.entryCount ?? 0)
        XCTAssertEqual(1, chartData?.x)
        XCTAssertEqual(2, chartData?.y)
        XCTAssertEqual(3, chartData?.data as? Int ?? 0)
    }
    
    private func generateDummyData() -> [LineChartDataSet] {
        var tags: [LineChartDataSet] = []
        let range = 8
        let upperRange = 2018
        let lowerRange = upperRange - range
        var colorCounter: Int = 0
        for i in 1...3 {
            var dataPoints: [ChartDataEntry] = []
            for j in 0...range {
                let time = Double(lowerRange + j)
                let measure = Double((arc4random_uniform(UInt32(115)) + UInt32(50)) )
                dataPoints.append(ChartDataEntry(x: time, y: measure, data: NSNumber(value: 3)))
            }
            colorCounter += 1
            
            let dataSet = LineChartDataSet(values: dataPoints, label: "TAG_\(i)")
            dataSet.lineCapType = .round
            dataSet.mode = .horizontalBezier
            dataSet.lineWidth = 1.5
            dataSet.circleRadius = 0.0
            
            let color: UIColor = UIColor.Predix.DataVisualizationSets.regular[colorCounter % UIColor.Predix.DataVisualizationSets.regular.count]
            dataSet.setColor(color)
            dataSet.setCircleColor(color)
            dataSet.colors = [color]
            dataSet.circleColors = [.red]
            tags.append(dataSet)
        }
        
        return tags
    }
}

private class RawDataTimeSeriesViewDelegate: TimeSeriesViewDelegate {
    var selectedTimeScale: Double?
    
    func valueSelected(timeSeriesView: PredixTimeSeriesView, timeScale: Double) {
        self.selectedTimeScale = timeScale
    }
}
