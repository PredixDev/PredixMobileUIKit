//
//  PredixSeriesWithLimitsViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by Goel, Shalab (GE Corporate) on 10/30/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest

@testable import PredixMobileUIKit

class PredixSeriesWithLimitsViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPrepareForInterfaceBuilderShouldInitializeWithDummyData() {
        let sView = PredixSeriesWithLimitsView()
        sView.prepareForInterfaceBuilder()
        XCTAssertTrue(sView.data?.dataSetCount ?? 0 > 0, "PrepareForInterfaceBuilder should initialize dummy data")
    }
    
    // MARK: PredixSeriesWithLimitsChartView IBInspectables test
    
    func testSetFillColorEnabled() {
        let sView = PredixSeriesWithLimitsView()
        sView.seriesFillColor = .red
        XCTAssertTrue(sView.fillColor == .red, "Fill Color should be changed for Chart Series")
    }
    
    func testGetFillColorEnabled() {
        let sView = PredixSeriesWithLimitsView()
        sView.fillColor = .blue
        XCTAssertTrue(sView.seriesFillColor == .blue, "Fill Color not be retrieved for Chart Series")
    }
    
    func testSetXAxisDateFormat() {
        let sView = PredixSeriesWithLimitsView()
        sView.horizontalDateFormat = "EEEEE"
        XCTAssertTrue(sView.xAxisDateFormat == "EEEEE", "X-Axis date format should be changed")
    }
    
    func testGetXAxisDateFormat() {
        let sView = PredixSeriesWithLimitsView()
        sView.xAxisDateFormat = "EEEE"
        XCTAssertTrue(sView.horizontalDateFormat == "EEEE", "X-Axis date format could not be retrieved for Chart Series")
    }
    
    // MARK: PredixSeriesWithLimitsChartView tests
    
    func testInitWithCoder() {
        let sView = PredixSeriesWithLimitsView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(sView)
        coder.finishEncoding()
        
        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newTSView = PredixSeriesWithLimitsView(coder: decoder)
        XCTAssertNotNil(newTSView)
    }
    
    func testtestInitWithFrame() {
        let rect = CGRect(x: 0.1, y: 0.2, width: 0.3, height: 0.4)
        let sView = PredixSeriesWithLimitsView(frame: rect)
        XCTAssertEqual(sView.frame.origin.x, rect.minX, accuracy: 0.01)
        XCTAssertEqual(sView.frame.origin.y, rect.minY, accuracy: 0.01)
        XCTAssertEqual(sView.frame.size.width, rect.width, accuracy: 0.01)
        XCTAssertEqual(sView.frame.size.height, rect.height, accuracy: 0.01)
    }
    
    func testloadLabelsAndValues() {
        let sView = PredixSeriesWithLimitsView()
        let (data, limits) = generateDummyData()
        sView.loadLabelsAndValues(data, limits: limits)
        XCTAssertTrue(sView.data?.dataSetCount ?? 0 > 0, "No datasets were loaded in prepareForInterfaceBuilder")
    }
    
    private func generateDummyData() -> ([TimeSeriesTag], [TimeSeriesLimitLine]) {
        
        let numPoints = 7
        let numLimitLines = 2
        
        var data: [TimeSeriesTag] = []
        
        var colors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
        
        let maxValueRand = 250.0
        let minValueRand = 50.0
        var date = Date()
        date = (Calendar.current as NSCalendar).date(byAdding: .day, value: (-1 * (numPoints-1)), to: date, options: [])!
        
        var minMeasure = maxValueRand
        var maxMeasure = minValueRand
        
        var dataPoints: [TimeSeriesDataPoint] = []
        for _ in 1 ... numPoints {
            let epochInMs = date.timeIntervalSince1970
            let measure = Double(getRandom(minValueRand, ceiling: maxValueRand))
            if measure < minMeasure {
                minMeasure = measure
            }
            if measure > maxMeasure {
                maxMeasure = measure
            }
            let dataPoint = TimeSeriesDataPoint(epochInMs:epochInMs, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        let series = TimeSeriesTag(name: "", dataPoints: dataPoints)
        data.append(series)
        
        var limits:[TimeSeriesLimitLine] = []
        for idx in 1 ... numLimitLines {
            let color: UIColor = colors[idx % colors.count]
            let limitValue = maxMeasure - 20 * Double(idx-1)
            
            let limit = TimeSeriesLimitLine(measure:limitValue, color:color)
            limits.append(limit)
        }
        return (data, limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
}
