//
//  PredixSeriesWithLimitsViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by Goel, Shalab (GE Corporate) on 10/30/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest

@testable import PredixMobileUIKit
import Charts

class PredixTrendProgressViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPrepareForInterfaceBuilderShouldInitializeWithDummyData() {
        let sView =  PredixTrendProgressView()
        sView.prepareForInterfaceBuilder()
        XCTAssertEqual(8, sView.data?.dataSets.first?.entryCount)
    }
    
    func testSettingTheCriticalLineColorEnabledFalseDoesNotDrawTheLine() {
        let trendView =  PredixTrendProgressView()
        trendView.criticalThresholdEnabled = false
        trendView.prepareForInterfaceBuilder()
        XCTAssertEqual(1, trendView.leftAxis.limitLines.count)
        XCTAssertEqual(UIColor.orange, trendView.leftAxis.limitLines.first?.lineColor)
    }
    
    func testSettingTheWarningLineColorEnabledFalseDoesNotDrawTheLine() {
        let trendView =  PredixTrendProgressView()
        trendView.warningThresholdEnabled = false
        trendView.prepareForInterfaceBuilder()
        XCTAssertEqual(1, trendView.leftAxis.limitLines.count)
        XCTAssertEqual(UIColor.red, trendView.leftAxis.limitLines.first?.lineColor)
    }
    
    func testNoLinesAreDrawnWhenBothWarningAndChriticalLinesAreDisabled() {
        let trendView =  PredixTrendProgressView()
        trendView.warningThresholdEnabled = false
        trendView.criticalThresholdEnabled = false
        trendView.prepareForInterfaceBuilder()
        XCTAssertEqual(0, trendView.leftAxis.limitLines.count)
    }
    
    func testSettingTheTextColorSetsItOnAllChartConfigurableLabels() {
        let trendView =  PredixTrendProgressView()
        trendView.textColor = .orange
        
        XCTAssertEqual(.orange, trendView.xAxis.labelTextColor)
        XCTAssertEqual(.orange, trendView.leftAxis.labelTextColor)
        XCTAssertEqual(.orange, trendView.rightAxis.labelTextColor)
        XCTAssertEqual(.orange, trendView.legend.textColor)
    }
    
    func testSettingTheChartBorderColorAlsoSetsTheAxisLineColors() {
        let trendView =  PredixTrendProgressView()
        trendView.chartBorderColor = .purple
        
        XCTAssertEqual(.purple, trendView.borderColor)
        XCTAssertEqual(.purple, trendView.leftAxis.axisLineColor)
        XCTAssertEqual(.purple, trendView.leftAxis.axisLineColor)
    }
    
    func testTheChartBorderColorIsReturnedWhenChartBorderColorIsCalled() {
        let trendView =  PredixTrendProgressView()
        trendView.borderColor = .purple
        
        XCTAssertEqual(.purple, trendView.chartBorderColor)
    }
    
    func testSettingTheWarningThresholdHigherThanTheHighestValueSetsTheLeftAxisMaxWhenIBDataIsLoaded() {
        let trendView = PredixTrendProgressView()
        trendView.warningThreshold = 1000
        trendView.criticalThreshold = 100
        
        trendView.prepareForInterfaceBuilder()
        
        XCTAssertEqual(1010.0, trendView.leftAxis.axisMaximum)
    }
    
    func testSettingTheCriticalThresholdHigherThanTheHighestValueSetsTheLeftAxisMaxWhenIBDataIsLoaded() {
        let trendView = PredixTrendProgressView()
        trendView.criticalThreshold = 1000
        trendView.warningThreshold = 100
        
        trendView.prepareForInterfaceBuilder()
        
        XCTAssertEqual(1010.0, trendView.leftAxis.axisMaximum)
    }
    
    func testInitWithCoder() {
        let sView = PredixTrendProgressView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(sView)
        coder.finishEncoding()
        
        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newTSView =  PredixTrendProgressView(coder: decoder)
        XCTAssertNotNil(newTSView)
    }
    
    func testLoadDataDrawsLinesByDefault() {
        let trendView = PredixTrendProgressView()
        let entry = ChartDataEntry(x: 1, y: 2)
        
        trendView.loadChart(data: [entry])
        
        XCTAssertEqual(2, trendView.leftAxis.limitLines.count)
    }
    
    func testtestInitWithFrame() {
        let rect = CGRect(x: 0.1, y: 0.2, width: 0.3, height: 0.4)
        let sView =  PredixTrendProgressView(frame: rect)
        
        XCTAssertEqual(sView.frame.origin.x, rect.minX, accuracy: 0.01)
        XCTAssertEqual(sView.frame.origin.y, rect.minY, accuracy: 0.01)
        XCTAssertEqual(sView.frame.size.width, rect.width, accuracy: 0.01)
        XCTAssertEqual(sView.frame.size.height, rect.height, accuracy: 0.01)
    }
    
    func testloadLabelsAndValues() {
        let sView =  PredixTrendProgressView()
        let (data, limits) = generateDummyData()
        sView.loadChart(data: data, limits: limits)
        XCTAssertEqual(8, sView.data?.dataSets.first?.entryCount)
    }
    
    private func generateDummyData() -> ([ChartDataEntry], [ChartDataEntryLimitLine]) {
        var colors: [UIColor] = [UIColor.orange, UIColor.red, UIColor.Predix.green3, UIColor.Predix.blue4]
        var thresholds = [70.0, 80.0]
        let today = Date()
        
        var dataPoints: [ChartDataEntry] = []
        for i in 0 ... 7 {
            let epochInMs = floor((today.timeIntervalSince1970 - 86400000.0 * Double(7 - i)))
            let measure = Double(arc4random_uniform(UInt32(100)))
            let dataPoint = ChartDataEntry(x: epochInMs, y: measure)
            dataPoints.append(dataPoint)
        }
        
        var limits: [ChartDataEntryLimitLine] = []
        for idx in 0 ..< 2 {
            let color: UIColor = colors[idx]
            let limitValue = (idx < thresholds.count) ? thresholds[idx] : 35 + (Double(idx-1) * 10)
            
            let limit = ChartDataEntryLimitLine(y:limitValue, color:color)
            limits.append(limit)
        }
        
        return (dataPoints, limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
}
