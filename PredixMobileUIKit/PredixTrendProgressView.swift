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
            xAxis.labelTextColor = textColor
            leftAxis.labelTextColor = textColor
            rightAxis.labelTextColor = textColor
            legend.textColor = textColor
        }
    }
    /// The border color of the chart
    @IBInspectable
    open var chartBorderColor: UIColor {
        get {
            return borderColor
        }
        set(newValue) {
            borderColor = newValue
            leftAxis.axisLineColor = newValue
            rightAxis.axisLineColor = newValue
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
    /// Display the warning threshold line on the chart
    @IBInspectable
    open var warningThresholdEnabled: Bool = true
    /// Display the critical threshold line on the chart
    @IBInspectable
    open var criticalThresholdEnabled: Bool = true
    /// Warning threshold color
    @IBInspectable
    open var warningThresholdColor: UIColor = UIColor.orange
    /// Critical threshold color
    @IBInspectable
    open var criticalThresholdColor: UIColor = UIColor.red
    /// Warning threshold
    /// Set to zero to disable warning thresholds
    @IBInspectable
    open var warningThreshold: Double = 70.0
    /// Critical threshold
    /// Set to zero to disable critical thresholds
    @IBInspectable
    open var criticalThreshold: Double = 80.0
    
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
    
    // MARK: - public functions
    /**
     Loads chart data with the given ChartDataEntrys.  If the warning or critical threshold limits have been enabled and set they will be displayed on the graph.
     
     - parameters:
         - data: The data entries to be displayed on the chart
     */
    open func loadChart(data: [ChartDataEntry]) {
        var limits: [ChartDataEntryLimitLine] = []
        
        if self.warningThresholdEnabled {
            limits.append(ChartDataEntryLimitLine(y: self.warningThreshold, color: self.warningThresholdColor))
        }
        
        if self.criticalThresholdEnabled {
            limits.append(ChartDataEntryLimitLine(y: self.criticalThreshold, color: self.criticalThresholdColor))
        }
        
        self.loadChart(data: data, limits: limits)
    }
    
    /// Helper function to populate the Area series chart based on timeseries tags array.
    /// - parameter tags: Array of `TimeSeriesTag`.
    open func loadChart(data: [ChartDataEntry], limits: [ChartDataEntryLimitLine]) {
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
        self.leftAxis.drawZeroLineEnabled = false
        self.leftAxis.gridColor = .lightGray
        self.leftAxis.drawLimitLinesBehindDataEnabled = true
    }
}

//Interface Builder dummy data generation
extension PredixTrendProgressView {
    ///:nodoc:
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeWithDummyData()
    }
    
    // MARK: - private functions
    private func initializeWithDummyData() {
        var dataPoints: [ChartDataEntry] = []
        var maxDataPoint = 0.0
        
        for i in 0 ... 7 {
            let epochInMs = Double(i) + 1
            let measure = Double(arc4random_uniform(UInt32(100)))
            let dataPoint = ChartDataEntry(x:epochInMs, y: measure)
            dataPoints.append(dataPoint)
            if measure > maxDataPoint {
                maxDataPoint = measure
            }
        }
        
        if self.warningThreshold > maxDataPoint {
            maxDataPoint = warningThreshold
        }
        
        if self.criticalThreshold > maxDataPoint {
            maxDataPoint = criticalThreshold
        }
        
        leftAxis.axisMaximum = maxDataPoint + 10.0
        
        loadChart(data: dataPoints)
    }
}

/// TimeSeries limit line model
public struct ChartDataEntryLimitLine {
    // swiftlint:disable identifier_name
    /// The value on the y access where you want the line to be displayed
    public var y: Double
    // swiftlint:enable identifier_name
    
    /// color for line to be drawn.
    public var color: UIColor
    
    /**
     Creates a ChartDataEntryLimitLine with where the line should be drawn and color
     
     - parameters:
         - y: Where on the Y-Axis you want the line to be drawn
         - color: The color of the line to be drawn
     */
    // swiftlint:disable identifier_name
    public init(y: Double, color: UIColor) {
        self.y = y
        self.color = color
    }
    // swiftlint:enable identifier_name
}
