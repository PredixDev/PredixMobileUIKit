//
//  PredixBarChartView.swift
//  PredixMobileUIKit
//
//  Created by Fouche, George (GE Healthcare) on 11/15/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Charts
import Foundation
import PredixSDK

class BarChartBuilder {
    
    var x: Double?
    var y: Double?
    var z: Double?
    
    typealias BuilderClosure = (BarChartBuilder) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}
open class PredixBarChartView: BarChartView {
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
    
    /// Predix Mobile Bar chart initial values
    fileprivate func initialize() {
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        xAxis.labelPosition = .bottom
        chartDescription?.enabled = false
    }
    
    /// Set message if there's not data provided
    public func setNoDataText(message: String) {
        noDataText = message
    }
    
    /// Add a limit line
    /// - parameter limit: Double number of where the line should be drawn verticaly
    /// - parameter label: String label of the line
    public func addALimit(limit: Double, label: String) {
        let ll = ChartLimitLine(limit: limit, label: label)
        rightAxis.addLimitLine(ll)
    }
    
    /// Set the x axis label text color
    /// - parameter uiColor: provide a color base on the class UIColor
    public func setXAxisLabelTextColor(uiColor: UIColor) {
        xAxis.labelTextColor = uiColor
    }
    
    /// Helper function to populate the bar chart based on one data entry
    /// - parameter xValues: String array of x values
    /// - parameter yValues: Double array of y values
    /// - parameter label: String label
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func loadChart(xValues: [String], yValues: [Double], label: String, showWithDefaultAnimation: Bool = true) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0 ..< yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        chartDataSet.colors = dataVisualizationColors
        
        let chartData = BarChartData(dataSet: chartDataSet)
        data = chartData
        
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        if showWithDefaultAnimation {
            animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        }
    }
    
    /// Helper function to populate the bar chart based on  two data entries
    /// - parameter xValues: String array of x values
    /// - parameter yValues1: Double array of the first data entry
    /// - parameter yValues2: Double array of the second data entry
    /// - parameter label: String label of the first data entry
    /// - parameter label2: String label of the second data entry
    /// - parameter uiColor1: provide a color base on the class UIColor for the first data entry
    /// - parameter uiColor2: provide a color base on the class UIColor for the second data entry
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func loadAndStackChart(xValues: [String], yValues1: [Double], yValues2: [Double], label1: String, label2: String, uiColor1AnduiColor2: ([UIColor],[UIColor]), showWithDefaultAnimation: Bool = true) {
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        
        for i in 0 ..< yValues1.count {
            // let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues1[i])
            dataEntries.append(dataEntry)
        }
        
        for i in 0 ..< yValues2.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues2[i])
            dataEntries2.append(dataEntry)
        }
        
        // chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label1)
        let chartDataSet1 = BarChartDataSet(values: dataEntries2, label: label2)
        
        (chartDataSet.colors, chartDataSet1.colors) = uiColor1AnduiColor2
      
        
        let dataSets: [BarChartDataSet] = [chartDataSet, chartDataSet1]
        data = BarChartData(dataSets: dataSets)
        
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        if showWithDefaultAnimation {
            animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        }
    }
}

