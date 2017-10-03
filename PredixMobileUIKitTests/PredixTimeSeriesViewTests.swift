//
//  PredixTimeSeriesViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by  on 10/2/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest

@testable import Charts
@testable import PredixMobileUIKit
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
    
    // MARK: PredixTimeSeriesView tests
    
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
        tsView.loadLabelsAndValues(generateDummyData())
        XCTAssertTrue(tsView.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }
    
    private func generateDummyData() -> [TimeSeriesTag] {
        var tags: [TimeSeriesTag] = []
        let range = 8
        let upperRange = 2018
        let lowerRange = upperRange - range
        for i in 1...3 {
            var dataPoints: [TimeSeriesDataPoint] = []
            for j in 0...range {
                let time = Double(lowerRange + j)
                let measure = Double((arc4random_uniform(UInt32(115)) + UInt32(50)) )
                let dataPoint = TimeSeriesDataPoint(epochInMs: Double(time), measure: measure)
                dataPoints.append(dataPoint)
            }
            let tag = TimeSeriesTag(name: "TAG_\(i)", dataPoints: dataPoints)
            tags.append(tag)
        }
        return tags
    }
}
