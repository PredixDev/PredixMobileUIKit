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

public enum Option{
    case toggleValues
    case toggleBarBorders
    case toggleEnableLegend
    case toggleDisableLegend
    case disableSideLabels
    case enableSideLabels
    case animateX
    case animateY
    case animateXY
}
/// To create a Bar Chart from the PredixBarChartView class, the Bar class is used to populate each data Bar on the chart.
public class Bar {
    var values: [Double]
    var label: String
    var colors: [UIColor] = []

    /// Initialize the values, label and color of the bar.
    /// - parameter yValues: the values the bar hold
    /// - parameter label: the bar label
    /// - parameter color: the bar color based on the class UIColor
    public init(_ values: [Double], label: String, colors: [UIColor]) {
        self.values = values
        self.label = label
        self.colors = colors
    }

    /// Initialize the values and label of the bar.
    /// - parameter yValues: the values the bar hold
    /// - parameter label: the bar label
    public init(_ values: [Double], label: String) {
        self.values = values
        self.label = label
    }
}

/// PredixBarChartView -- Bar Chart
@IBDesignable
open class PredixBarChartView: BarChartView {
var limitLine = ChartLimitLine()
var chartData = BarChartData(dataSets: [])
var xAxisValues: [String] = []
    
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
           initLegend()
           initXaxis()
           initYaxis()
    }

    /// Set message if there's no data provided
    public func setNoDataText(message: String) {
        noDataText = message
    }

    
    /// Add a limit line
    /// - parameter limit: Double number of where the line should be drawn verticaly
    /// - parameter label: String label of the line
    public func addALimit(limit: Double, label: String) {
        limitLine = ChartLimitLine(limit: limit, label: label)
        rightAxis.addLimitLine(limitLine)
    }

    /// Remove the added limit on the chart
    public func removeLimit() {
        rightAxis.removeLimitLine(limitLine)
    }

    /// Set the x axis label text color
    /// - parameter uiColor: provide a color base on the class UIColor
    public func setXAxisLabelTextColor(uiColor: UIColor) {
        xAxis.labelTextColor = uiColor
    }

    func initLegend(){
         chartDescription?.enabled = false
        let legend = self.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0
    }
    
    func initXaxis(){
        let xaxis = self.xAxis
        xaxis.valueFormatter = IndexAxisValueFormatter()
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.granularity = 1
    }
    
    func initYaxis(){
        let yaxis = self.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 1
        yaxis.drawGridLinesEnabled = false
        self.rightAxis.enabled = true
    }
    
    
    /// Helper function to populate the Bar Chart based on each Bar data entry from the Bar class.
    /// - parameter xAxisValues: String array of the x axis values.
    /// - parameter bars: populate each data bars  on the Bar Chart.
    /// - parameter stackBars: optional parameter to show the bar staked or unstaked. Defaults to `true`.
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func create(xAxisValues: [String], bars: [Bar], stackBars: Bool = true, showWithDefaultAnimation: Bool = true) {
        self.xAxisValues = xAxisValues
        
        var dataSets: [BarChartDataSet] = []
        for bar in bars {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0 ..< bar.values.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: bar.values[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(values: dataEntries, label: bar.label)
            if bar.colors != [] {
                chartDataSet.colors = bar.colors
            }
            dataSets.append(chartDataSet)
        }
        
        chartData = BarChartData(dataSets: dataSets)
        stack(stackBars)
        
        if showWithDefaultAnimation {
            animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        }
      
    }
    
   public func stack(_ stackBars:Bool){

        
        //let groupSpace = (1-nb)/(n+1)

        let groupCount = xAxisValues.count
        let xaxis = self.xAxis
        xaxis.valueFormatter = IndexAxisValueFormatter(values:xAxisValues)

        if stackBars {
            
            let stackBarsStatingNumber = -0.5
            xaxis.centerAxisLabelsEnabled = false
            xaxis.axisMinimum = stackBarsStatingNumber
            xaxis.axisMaximum = stackBarsStatingNumber +  Double(groupCount)
            self.notifyDataSetChanged()
            self.data = chartData
           
            
            
        }else{
            
            let barCount =  chartData.dataSets.count
            let barSpace = 0.05
            let groupSpace = (1.0 - Double(barCount) * barSpace)/(Double(barCount)+1.0)
            let barWidth = groupSpace
          
            
            chartData.barWidth = barWidth
            xaxis.centerAxisLabelsEnabled = true
            let groupBarsStatingNumber = 0.0
            xaxis.axisMinimum = groupBarsStatingNumber
            let individualGroupSpace = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
            xaxis.axisMaximum = groupBarsStatingNumber + individualGroupSpace * Double(groupCount)
            
            chartData.groupBars(fromX: Double(groupBarsStatingNumber), groupSpace: groupSpace, barSpace: barSpace)
            self.notifyDataSetChanged()
            self.data = chartData
           

        }
        

    }
    
    
    public func handleOption(_ option: Option){
        self.legend.enabled = true
        self.setNeedsDisplay()
        switch option {
        case .toggleValues:
            for set in self.data!.dataSets {
                set.drawValuesEnabled = !set.drawValuesEnabled
            }
            self.setNeedsDisplay()
            
        case .toggleBarBorders:
            for set in self.data!.dataSets {
                if let set = set as? BarChartDataSet {
                    set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
                }
            }
            self.setNeedsDisplay()
        case .animateX:
            self.animate(xAxisDuration: 3,easingOption: .easeInBounce)
        
        case.animateY:
            self.animate(yAxisDuration: 3,easingOption: .easeInBounce)
            
        case .animateXY:
            self.animate(xAxisDuration: 3.0, yAxisDuration: 3.0,easingOption: .easeInBounce)
            
        case .toggleEnableLegend:
            self.legend.enabled = true
            self.setNeedsDisplay()
            
        case .toggleDisableLegend:
            self.legend.enabled = false
            self.setNeedsDisplay()
            
        case .disableSideLabels:
            self.rightAxis.drawLabelsEnabled = false
            self.leftAxis.drawLabelsEnabled = false
            self.setNeedsDisplay()
        case .enableSideLabels:
            self.rightAxis.drawLabelsEnabled = true
            self.leftAxis.drawLabelsEnabled = true
            self.setNeedsDisplay()
        }
    }
}

