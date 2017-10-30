//
//  PredixSeriesWithLimitsView.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

/// PredixSeriesWithLimitsView -- Line Area Series chart  with optional limit lines.
@IBDesignable
open class PredixSeriesWithLimitsView: LineChartView {
    
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    
    open var fillColor:UIColor?
    
    open var horizontalDateFormat: String = "EEE"
    
    open var verticalNumberFormat: String?
    
    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /// :nodoc:
    override open func setNeedsDisplay() {
        if self.data != nil {
            self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
        }
        super.setNeedsDisplay()
    }
    
    // MARK: - public functions
    
    /// Helper function to populate the Area series chart based on timeseries tags array.
    /// - parameter tags: Array of `TimeSeriesTag`.
    public func loadLabelsAndValues(_ data: [TimeSeriesTag], limits:[TimeSeriesLimitLine]) {
        self.xAxis.valueFormatter = TimestampValueFormatter(self.horizontalDateFormat)
        self.leftAxis.valueFormatter = MeasureValueFormatter(self.horizontalDateFormat)
        
        var dataSets: [LineChartDataSet] = []
        for dataPoints in data {
            var dataEntries: [ChartDataEntry] = []
            for dataPoint in dataPoints.dataPoints {
                let dataEntry: ChartDataEntry = ChartDataEntry(x: dataPoint.epochInMs, y: dataPoint.measure)
                dataEntries.append(dataEntry)
            }
            
            let dataSet: LineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
            dataSet.lineWidth = 1.5
            dataSet.mode = .horizontalBezier
            dataSet.lineCapType = .round
            
            let color = self.fillColor ?? .lightGray
            dataSet.setColor(color)
            dataSet.colors = [color]
            
            dataSet.drawValuesEnabled = false
            dataSet.drawCirclesEnabled = false
            dataSet.drawFilledEnabled = true
            dataSet.fillColor = color
            
            dataSets.append(dataSet)
            
            self.xAxis.setLabelCount(dataPoints.dataPoints.count, force:true)
        }
        
        // draw horizontal limit lines
        self.leftAxis.removeAllLimitLines()
        for limit in limits {
            let limitLine = ChartLimitLine()
            limitLine.limit = limit.measure
            limitLine.lineColor = limit.color
            self.leftAxis.addLimitLine(limitLine)
        }
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 9.0))
        self.data = data
        self.notifyDataSetChanged()
    }
    
    // MARK: - fileprivate functions
    
    /// initialization for Predix Series Chart with Limits
    fileprivate func initialize() {
        self.backgroundColor? = .white
        self.leftAxis.enabled = true
        self.rightAxis.enabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.xAxis.enabled = true
        
        self.drawBordersEnabled = true
        self.dragEnabled = true
        self.setScaleEnabled(true)
        self.pinchZoomEnabled = true
        
        self.legend.enabled = false
        
        self.xAxis.labelPosition = .bottom
        self.chartDescription?.text = ""
        
        self.xAxis.drawGridLinesEnabled = false
        
        self.leftAxis.drawGridLinesEnabled = true
        self.leftAxis.gridLineWidth = 0.5
        self.leftAxis.drawZeroLineEnabled = false;
        self.leftAxis.gridColor = .lightGray
        self.leftAxis.drawLimitLinesBehindDataEnabled = true;
    }
}

/// Date Formatter -- format can be specified as inspectable property via IB
// programmatically as chart property
class TimestampValueFormatter: NSObject, IAxisValueFormatter {
    fileprivate var formatter: DateFormatter?

    public override init()
    {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "EEE"
    }
    
    public init(_ format:String)
    {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = format
    }
    
    public func stringForValue(_ value: Double,
                               axis: AxisBase?) -> String {
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

///Converts measure values as percent strings
class MeasureValueFormatter: NSObject, IAxisValueFormatter {
    fileprivate var formatter: NumberFormatter?
    
    public override init()
    {
        super.init()
        
        self.formatter = NumberFormatter()
        self.formatter?.numberStyle = .percent
    }
    
    public init(_ format:String)
    {
        super.init()
        
        self.formatter = NumberFormatter()
        self.formatter?.numberStyle = .percent
        
    }
    
    public func stringForValue(_ value: Double,
                               axis: AxisBase?) -> String {
        return self.formatter?.string(from:NSNumber(value:value/100.0)) ?? ""
    }
}

