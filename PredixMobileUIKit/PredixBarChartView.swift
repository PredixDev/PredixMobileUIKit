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

/// The Bar class
public class Bar {
    var yValues: [Double]
    var label: String
    var color: [UIColor]?
    /// - parameter yValues: Double array of y values
    /// - parameter label: bar label
    /// - parameter color: provide a color base on the class UIColor
    public init(_ yValues: [Double], label: String, color: [UIColor]) {
        self.yValues = yValues
        self.label = label
        self.color = color
    }

    /// - parameter yValues: Double array of y values
    /// - parameter label: bar label
    public init(_ yValues: [Double], label: String) {
        self.yValues = yValues
        self.label = label
    }
}

/// PredixBarChartView -- Bar Chart
open class PredixBarChartView: BarChartView {
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
        legend.verticalAlignment = .bottom
        xAxis.labelPosition = .bottom
        chartDescription?.enabled = false
    }

    /// Set message if there's no data provided
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

    /// Helper function to populate the Bar Chart based on each Bar data entry
    /// - parameter xAxisValues: String array of the x axis values
    /// - parameter stackBars: optional parameter to show the bar staked or unstaked. Defaults to `true`.
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func create(xAxisValues: [String], bars: [Bar], stackBars: Bool = true, showWithDefaultAnimation: Bool = true) {
        var dataSets: [BarChartDataSet] = []
        for bar in bars {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0 ..< bar.yValues.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: bar.yValues[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(values: dataEntries, label: bar.label)
            if bar.color != nil {
                chartDataSet.colors = bar.color!
            }
            dataSets.append(chartDataSet)
        }

        let ChartData = BarChartData(dataSets: dataSets)

        if stackBars == false {
            let groupCount = xAxisValues.count
            let groupSpace: Double = 0.08
            let barSpace: Double = 0.05
            ChartData.groupBars(fromX: Double(0.0), groupSpace: groupSpace, barSpace: barSpace)
            let theGroupSpace = ChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
            xAxis.axisMaximum = Double(0) + theGroupSpace * Double(groupCount)
        }
        data = ChartData
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)

        if showWithDefaultAnimation {
            animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        }
    }
}
