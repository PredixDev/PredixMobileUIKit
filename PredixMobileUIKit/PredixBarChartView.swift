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

/// List of options that can be use on the Bar Chart
public enum Option {
    // toggle on or off,  Bars value on the chart.
    case toggleValues
    // toggle on or off, Bar borders on the chart.
    case toggleBarBorders
    // enable the legend display on the chart.
    case enableLegend
    // disable the legend display on the chart.
    case disableLegend
    // disable side labels on the chart.
    case disableSideLabels
    // enable side labels on the chart.
    case enableSideLabels
    // remove Limit Line on the chart.
    case removeLimitLine
    // animate the x axis on the chart.
    case animateX
    // animate the y axis on the chart.
    case animateY
    // animate both the x and y axies on the chart.
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

    // MARK: Internal variables

    internal var limitLine = ChartLimitLine()
    var xAxisValues: [String] = []
    var bars: [Bar] = []

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
        chartDescription?.enabled = false
    }

    /// Initial legend
    internal func initLegend() {
        let legend = self.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0
        legend.xOffset = 10.0
        legend.yEntrySpace = 0.0
    }

    /// Initial x axis
    internal func initXaxis() {
        let xaxis = xAxis
        xaxis.valueFormatter = IndexAxisValueFormatter()
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.granularity = 1
    }

    /// Initial y axis
    internal func initYaxis() {
        let yLeftAxis = leftAxis
        yLeftAxis.spaceTop = 0.35
        yLeftAxis.axisMinimum = 1
        yLeftAxis.drawGridLinesEnabled = false

        let yRightAxis = rightAxis
        yRightAxis.spaceTop = 0.35
        yRightAxis.axisMinimum = 1
        yRightAxis.drawGridLinesEnabled = false
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

    /// Helper function to populate the Bar Chart based on each Bar data entry from the Bar class.
    /// - parameter xAxisValues: String array of the x axis values.
    /// - parameter bars: populate each data bars on the Bar Chart.
    /// - parameter stackBars: optional parameter to show the bar staked or unstaked. Defaults to `true`.
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func create(xAxisValues: [String], bars: [Bar], stackBars: Bool = true, showWithDefaultAnimation: Bool = true) {

        self.xAxisValues = xAxisValues
        self.bars = bars

        stack(stackBars)

        if showWithDefaultAnimation {
            animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        }
    }

    /// Stack or group the Bars on the chart
    public func stack(_ stackBars: Bool) {
        if stackBars {
            stackBarsOnChart()
        } else {
            groupBarsOnChart()
        }
    }

    /// Create all the bar data sets from each Bar provided
    /// - parameter bars: each data bars neend on the Chart.
    func createDataSets(bars: [Bar]) -> [BarChartDataSet] {
        var dataSets: [BarChartDataSet] = []
        for bar in bars {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0 ..< bar.values.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: bar.values[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(values: dataEntries, label: bar.label)
            if !bar.colors.isEmpty {
                chartDataSet.colors = bar.colors
            }
            dataSets.append(chartDataSet)
        }
        return dataSets
    }

    /// Handle the options provided
    /// - parameter option: choose one of the option from the Option class.
    public func handleOption(_ option: Option) {
        legend.enabled = true
        setNeedsDisplay()
        switch option {
        case .toggleValues:
            toggleValues()

        case .toggleBarBorders:
            toggleBarBorders()

        case .animateX:
            animate(xAxisDuration: 3, easingOption: .easeInBounce)

        case .animateY:
            animate(yAxisDuration: 3, easingOption: .easeInBounce)

        case .animateXY:
            animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeInBounce)

        case .enableLegend:
            toggleLegend(true)

        case .disableLegend:
            toggleLegend(false)

        case .disableSideLabels:
            toggleSideLabels(false)

        case .enableSideLabels:
            toggleSideLabels(true)
        case .removeLimitLine:
            removeLimit()
        }
    }

    /// Stacks all Bar DataSets  in the Chart
    internal func stackBarsOnChart() {
        if !bars.isEmpty {

            let groupCount = xAxisValues.count
            let xaxis = xAxis
            xaxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)

            let stackBarsDataSets = createDataSets(bars: bars)
            let stackBarsCharData = BarChartData(dataSets: stackBarsDataSets)

            let stackBarsStatingNumber = -0.5
            xaxis.centerAxisLabelsEnabled = false
            xaxis.axisMinimum = stackBarsStatingNumber
            xaxis.axisMaximum = stackBarsStatingNumber + Double(groupCount)
            data = stackBarsCharData
        }
    }

    /// Groups all Bar DataSets in the Chart
    internal func groupBarsOnChart() {
        if !bars.isEmpty {

            let groupCount = xAxisValues.count
            let xaxis = xAxis
            xaxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)

            let dataSets = createDataSets(bars: bars)
            let groupBarsChartData = BarChartData(dataSets: dataSets)
            let barCount = groupBarsChartData.dataSets.count
            let barSpace = 0.05
            let groupBarsStatingNumber = 0.0

            /*
             The equation to find the interval per "group" is:
             (groupSpace * barSpace) * n + groupSpace = 1
             Therefore by finding groupSpace we get:
             groupSpace = 1 - numberOfBars * BarSpace / numberOfBars +1
             */
            let groupSpace = (1.0 - Double(barCount) * barSpace) / (Double(barCount) + 1.0)
            let barWidth = groupSpace

            groupBarsChartData.barWidth = barWidth
            xaxis.centerAxisLabelsEnabled = true

            xaxis.axisMinimum = groupBarsStatingNumber
            let individualGroupSpace = groupBarsChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
            xaxis.axisMaximum = groupBarsStatingNumber + individualGroupSpace * Double(groupCount)
            groupBarsChartData.groupBars(fromX: Double(groupBarsStatingNumber), groupSpace: groupSpace, barSpace: barSpace)
            data = groupBarsChartData
        }
    }

    /// Call this function will add Bar Borders. Call it again will remove the Bar Border
    internal func toggleValues() {
        for set in data!.dataSets {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        setNeedsDisplay()
    }

    /// Call this function will add Bar Borders. Call it again will remove the Bar Border
    internal func toggleBarBorders() {
        for set in data!.dataSets {
            if let set = set as? BarChartDataSet {
                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
            }
        }
        setNeedsDisplay()
    }

    /// Enable and disable the Legends on the Chart
    /// - parameter enable: `true` to enable, `false` to disable
    internal func toggleLegend(_ toggle: Bool) {
        legend.enabled = toggle
        setNeedsDisplay()
    }

    /// Enable and disable the side labels
    /// - parameter toggle: `true` to enable, `false` to disable
    internal func toggleSideLabels(_ toggle: Bool) {
        rightAxis.drawLabelsEnabled = toggle
        leftAxis.drawLabelsEnabled = toggle
        setNeedsDisplay()
    }
}
