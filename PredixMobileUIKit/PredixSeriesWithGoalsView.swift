//
//  PredixTimeSeriesView.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

/// PredixSeriesWithGoalsView -- Line Area Series chart  with optional goal lines.
@IBDesignable
open class PredixSeriesWithGoalsView: LineChartView {
    
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    
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
    
    /// Helper function to populate the timeseries chart based on timeseries tags array.
    /// - parameter tags: Array of `SeriesData`.
    public func loadLabelsAndValues(_ data: [SeriesData]) {
        var dataSets: [LineChartDataSet] = []
        var colorCounter: Int = 0
        for dataPoints in data {
            var dataEntries: [ChartDataEntry] = []
            for dataPoint in dataPoints.dataPoints {
                let dataEntry: ChartDataEntry = ChartDataEntry(x: dataPoint.label, y: dataPoint.measure)
                dataEntries.append(dataEntry)
            }
            colorCounter += 1
            
            let dataSet: LineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
            dataSet.lineWidth = 1.5
            dataSet.mode = .horizontalBezier
            dataSet.circleRadius = 0
            dataSet.circleHoleRadius = 0.0
            
            let color: UIColor = self.dataVisualizationColors[colorCounter % dataVisualizationColors.count]
            dataSet.setColor(color)
            dataSet.setCircleColor(color)
            dataSet.colors = [color]
            dataSet.circleColors = [.red]
            dataSets.append(dataSet)
        }
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 9.0))
//        DispatchQueue.main.sync {
            self.data = data
            self.notifyDataSetChanged()
//            setNeedsDisplay()
//        }
        
    }
    
    // MARK: - fileprivate functions
    
    /// Predix Mobile Donut chart initial values
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
        
        self.xAxis.valueFormatter = DateFormatterValueFormatter()
    }
}

open class DateFormatterValueFormatter: NSObject, IAxisValueFormatter {
    open var formatter: DateFormatter?
    fileprivate var stringReps: [String]?

    public override init()
    {
        super.init()
        
        self.formatter = DateFormatter()
        self.stringReps = self.formatter?.shortWeekdaySymbols
    }
    
    @objc public init(formatter: DateFormatter)
    {
        super.init()
        
        self.formatter = formatter
        self.stringReps = self.formatter?.shortWeekdaySymbols
    }
    
    public func stringForValue(_ value: Double,
                               axis: AxisBase?) -> String {
        let idx = Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: value))
        return self.stringReps?[idx-1] ?? ""
    }
    
}

