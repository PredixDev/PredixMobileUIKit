//
//  SeriesWithLimitsChartViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import Charts

class TrendProgressChartViewController: UIViewController {

    @IBOutlet weak var chartView: PredixTrendProgressView!
    @IBOutlet weak var numPointsSlider: UISlider!
    @IBOutlet weak var limitLinesSlider: UISlider!
    @IBOutlet weak var numPointsLabel: UILabel!
    @IBOutlet weak var limitLinesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chartView.delegate = self
        
        let (data, limits) = self.generateDummyData(7, numLimitLines: 2)
        self.chartView.loadChart(data: data, limits:limits)
        self.chartView.leftAxis.axisRange = 100.0
        self.chartView.leftAxis.axisMinimum = 0.0
        self.chartView.leftAxis.axisMaximum = 100.0
        self.chartView.xAxis.valueFormatter = TimestampValueFormatter()
        self.chartView.leftAxis.valueFormatter = PercentValueFormatter()
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        let numPoints = Int(self.numPointsSlider.value)
        let numLimitLines = Int(self.limitLinesSlider.value)
        let (data, limits) = self.generateDummyData(numPoints, numLimitLines: numLimitLines)
        self.chartView.loadChart(data: data, limits:limits)
    }

    // MARK: - private functions
    private func generateDummyData(_ numPoints: Int, numLimitLines: Int) -> ([ChartDataEntry], [ChartDataEntryLimitLine]) {
        self.numPointsLabel.text = "\(numPoints) Data Points Selected"
        self.limitLinesLabel.text = "\(numLimitLines) Limit Lines Selected"
        
        var colors: [UIColor] = [self.chartView.warningThresholdColor, self.chartView.criticalThresholdColor, UIColor.Predix.green3, UIColor.Predix.blue4]
        var thresholds = [70.0, 80.0]
        let today = Date()
        
        var dataPoints: [ChartDataEntry] = []
        for i in 0 ... numPoints {
            let epochInMs = floor((today.timeIntervalSince1970 - 86400000.0 * Double(numPoints - i)))
            let measure = Double(arc4random_uniform(UInt32(100)))
            let dataPoint = ChartDataEntry(x: epochInMs, y: measure)
            dataPoints.append(dataPoint)
        }
        
        var limits: [ChartDataEntryLimitLine] = []
        for idx in 0 ..< numLimitLines {
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

extension TrendProgressChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("chartScaled")
    }
    
    func chartTranslated(_ chartView: ChartViewBase, pointX: CGFloat, pointY: CGFloat) {
        print("chartTranslated")
    }
}

private class PercentValueFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(format: "%d%%", Int(value))
    }
}

/// Date Formatter -- format can be specified as inspectable property via IB
// programmatically as chart property
private class TimestampValueFormatter: NSObject, IAxisValueFormatter {
    fileprivate var formatter: DateFormatter?
    
    override init() {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "EEE"
    }
    
    init(_ format: String) {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = format
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let today = Date()
        let otherDay = Date(timeIntervalSince1970: value)
        
        let todayDay = Calendar.current.component(.day, from: today)
        let todayMonth = Calendar.current.component(.month, from: today)
        let todayYear = Calendar.current.component(.year, from: today)
        
        let day = Calendar.current.component(.day, from: otherDay)
        let month = Calendar.current.component(.month, from: otherDay)
        let year = Calendar.current.component(.year, from: otherDay)
        
        if todayDay == day && todayMonth == month && todayYear == year {
            return "Today"
        }
        
        return self.formatter?.string(from: otherDay) ?? ""
    }
}
