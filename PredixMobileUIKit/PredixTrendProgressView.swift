//
//  PredixSeriesWithLimitsView.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

/// PredixSeriesWithLimitsView -- Line Area Series chart  with optional limit lines.
@IBDesignable
open class PredixTrendProgressView: LineChartView {
    
    /// Sets the text color for the chat legends and data
    @IBInspectable
    open var textColor: UIColor = UIColor.black {
        didSet {
            self.xAxis.labelTextColor = textColor
            self.leftAxis.labelTextColor = textColor
            self.rightAxis.labelTextColor = textColor
            self.legend.textColor = textColor
        }
    }
    @IBInspectable
    open var chartBorderColor: UIColor {
        get {
            return borderColor
        }
        set(newValue) {
            borderColor = newValue
            self.leftAxis.axisLineColor = newValue
            self.rightAxis.axisLineColor = newValue
        }
    }
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    /// The color of the graph line
    @IBInspectable
    open var lineColor: UIColor?
    /// The fill color you want to use to fill under the graph line
    @IBInspectable
    open var progressFillColor: UIColor?
    /// Warning threshold color
    @IBInspectable
    public var warningThresholdColor: UIColor = UIColor.orange
    /// Critical threshold color
    @IBInspectable
    public var criticalThresholdColor: UIColor = UIColor.red
    /// Warning threshold
    /// Set to zero to disable warning thresholds
    @IBInspectable
    public var warningThreshold: Double = 0.00
    /// Critical threshold
    /// Set to zero to disable critical thresholds
    @IBInspectable
    public var criticalThreshold: Double = 0.00
    /// The data formation for the horizontal date *default:* EEE
    @IBInspectable
    open var xAxisDateFormat: String = "EEE" {
        didSet {
            self.xAxis.valueFormatter = TimestampValueFormatter(xAxisDateFormat)
        }
    }
    /// The number format for the vertical label
    @IBInspectable
    open var yAxisNumberFormat: String? {
        didSet {
            let format = yAxisNumberFormat ?? ""
            self.leftAxis.valueFormatter = MeasureValueFormatter(format)
        }
    }
    
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
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.data != nil {
            self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
        }
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
    public func loadLabelsAndValues(_ data: [ChartDataEntry], limits:[ChartDataEntryLimitLine]) {
        var dataSets: [LineChartDataSet] = []
        
        let dataSet: LineChartDataSet = LineChartDataSet(values: data, label: "")
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier
        
        let fillColor = self.progressFillColor ?? UIColor.Predix.gray13
        let lineColor = self.lineColor ?? UIColor.Predix.gray16
        dataSet.setColor(lineColor)
        dataSet.colors = [lineColor]
        dataSet.valueTextColor = self.textColor
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = fillColor
        dataSet.fillAlpha = 1.0
        
        let topGradientColor = UIColor(red: fillColor.redValue, green: fillColor.greenValue, blue: fillColor.blueValue, alpha: 1.0)
        let bottomGradientColor = UIColor(red: fillColor.redValue, green: fillColor.greenValue, blue: fillColor.blueValue, alpha: 0.85)
        let colours = [topGradientColor.cgColor, bottomGradientColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        if let fillGradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil) {
            dataSet.fill = Fill.fillWithLinearGradient(fillGradient, angle: 270)
        }
        
        dataSets.append(dataSet)
        
        self.xAxis.setLabelCount(data.count, force:true)
        
        // draw horizontal limit lines
        self.leftAxis.removeAllLimitLines()
        self.leftAxis.drawLimitLinesBehindDataEnabled = false
        for limit in limits {
            let limitLine = ChartLimitLine()
            limitLine.limit = limit.y
            limitLine.lineColor = limit.color
            
            self.leftAxis.addLimitLine(limitLine)
        }
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        self.data = data
        self.notifyDataSetChanged()
    }
    
    // MARK: - fileprivate functions
    
    /// initialization for Predix Series Chart with Limits
    fileprivate func initialize() {
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

//IB Inspectables
extension PredixTrendProgressView {
    ///:nodoc:
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeWithDummyData()
        self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
    }
    
    // MARK: - private functions
    private func initializeWithDummyData() {
        
        let numLimitLines = 2
        
        let daysOfTheWeek = ["Mon", "Tues", "Wed", "Thurs", "Today"]
        var colors: [UIColor] = [self.warningThresholdColor, self.criticalThresholdColor]
        var thresholds = [0.70, 0.80]
        
        var dataPoints: [ChartDataEntry] = []
        for i in 0 ... daysOfTheWeek.count {
            let epochInMs = Double(i)
            let measure = Double(arc4random_uniform(UInt32(100)))
            let dataPoint = ChartDataEntry(x:epochInMs, y: measure)
            dataPoints.append(dataPoint)
        }
        
        var limits:[ChartDataEntryLimitLine] = []
        for idx in 1 ... numLimitLines {
            let color: UIColor = colors[idx - 1]
            let limitValue = thresholds[idx - 1]
            
            let limit = ChartDataEntryLimitLine(y:limitValue, color:color)
            limits.append(limit)
        }
        
        loadLabelsAndValues(dataPoints, limits:limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
}

/// TimeSeries limit line model
public struct ChartDataEntryLimitLine {
    /// The value on the y access where you want the line to be displayed
    public var y: Double
    
    /// color for line to be drawn.
    public var color: UIColor
    
    /**
     Creates a ChartDataEntryLimitLine with where the line should be drawn and color
     
     - parameters:
         - y: Where on the Y-Axis you want the line to be drawn
         - color: The color of the line to be drawn
     */
    public init(y: Double, color: UIColor) {
        self.y = y
        self.color = color
    }
}

/// Date Formatter -- format can be specified as inspectable property via IB
// programmatically as chart property
private class TimestampValueFormatter: NSObject, IAxisValueFormatter {
    fileprivate var formatter: DateFormatter?

    public override init() {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = "EEE"
    }
    
    public init(_ format:String) {
        super.init()
        
        self.formatter = DateFormatter()
        self.formatter?.dateFormat = format
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
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
private class MeasureValueFormatter: NSObject, IAxisValueFormatter {
    fileprivate var formatter: NumberFormatter?
    
    public override init() {
        super.init()
        
        self.formatter = NumberFormatter()
        self.formatter?.numberStyle = .percent
    }
    
    public init(_ format:String) {
        super.init()
        
        self.formatter = NumberFormatter()
        self.formatter?.numberStyle = .percent
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return self.formatter?.string(from:NSNumber(value:value/100.0)) ?? ""
    }
}


