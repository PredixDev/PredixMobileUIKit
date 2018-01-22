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

// MARK: - The Option Enum

/// List of animation options that can be used on the Bar Chart
public enum BarChartAnimationOption {
    /// animate the x axis on the chart
    case animateX
    /// animate the y axis on the chart
    case animateY
    /// animate both the x and y axies on the chart
    case animateXY
}

public enum BarChartToggleOption {
    /// toggle on or off, Bars value on the chart
    case toggleValues
    /// toggle on or off, Bar borders on the chart
    case toggleBarBorders
    /// toggle on or off, the legend display on the chart
    case toggleLegend
    /// toggle on or off, side labels on the chart
    case toggleSideLabels
}

// MARK: - The Bar Class

/// To create a Bar Chart from the PredixBarChartView class, the Bar class is used to populate each data Bar on the chart.
public class Bar {
    var values: [Double]
    var label: String
    var colors: [UIColor] = []

    /// Initialize the values, label and color of the bar
    /// - parameter values: the values the bar hold
    /// - parameter label: the bar label
    /// - parameter color: the bar color based on the class UIColor.
    public init(_ values: [Double], label: String, colors: [UIColor]) {
        self.values = values
        self.label = label
        self.colors = colors
    }

    /// Initialize the values and label of the bar.
    /// A *default* color gray is used if color is not provided.
    /// - parameter values: the values the bar hold.
    /// - parameter label: the bar label.
    public init(_ values: [Double], label: String) {
        self.values = values
        self.label = label
        colors = [UIColor.gray]
    }
}

// MARK: - The PredixBarChartView Class

/// PredixBarChartView -- Bar Chart
@IBDesignable
open class PredixBarChartView: BarChartView {

    // MARK: PredixBarCharView Internal Variables

    internal var limitLine = ChartLimitLine()
    var xAxisValues: [String] = []
    var bars: [Bar] = []

    // MARK: PredixBarChartView Initial Values

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

    // MARK: PredixBarChartView Adding Displaying or Removing a Limit Line

    /// Add a horizontal limit line on the bar chart. The line in the chart marks a certain maximum or limit on the x axis)
    /// - parameter limit: limit value
    /// - parameter label: name of the label line
    public func addLimitLine(limit: Double, label: String) {
        limitLine = ChartLimitLine(limit: limit, label: label)
        rightAxis.addLimitLine(limitLine)
        setNeedsDisplay()
    }

    /// Remove the added limit line on the chart.
    public func removeLimitLine() {
        rightAxis.removeLimitLine(limitLine)
        setNeedsDisplay()
    }

    // MARK: PredixBarChartView creating the Bar Chart Logic

    ///  Populate the Bar Chart based on each Bar data entry from the Bar class.
    /// - parameter xAxisValues: String array of the x axis values.
    /// - parameter bars: populate each data bars on the Bar Chart.
    /// - parameter stackBars: optional parameter to show the bar staked or grouped. Defaults to `true`.
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func create(xAxisValues: [String], bars: [Bar], stackBars: Bool = true, showWithDefaultAnimation: Bool = true) {

        self.xAxisValues = xAxisValues
        self.bars = bars

        stack(stackBars)

        if showWithDefaultAnimation {
            changeAnimationOption(.animateXY)
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
    /// - parameter bars: each data bars needed on the Chart
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

    /// Stacks all Bar DataSets in the Chart
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

    // MARK: PredixBarChartView  Handling Option Logic

    /// Handle the options provided
    /// - parameter option: choose one of the option from the AnimationOption enum
    public func changeAnimationOption(_ animationOption: BarChartAnimationOption) {
        switch animationOption {
        case .animateX:
            animate(xAxisDuration: 3, easingOption: .easeInBounce)

        case .animateY:
            animate(yAxisDuration: 3, easingOption: .easeInBounce)

        case .animateXY:
            animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeInBounce)
        }
    }

    /// Handle the options provided
    /// - parameter option: choose one of the option from the BarChartOption enum
    public func changeToggleOption(_ barChartOption: BarChartToggleOption) {
        switch barChartOption {
        case .toggleValues:
            toggleValues()

        case .toggleBarBorders:
            toggleBarBorders()

        case .toggleLegend:
            toggleLegend()

        case .toggleSideLabels:
            toggleSideLabels()
        }
    }

    /// Call this function will add bar borders. Call it again will remove the bar borders.
    internal func toggleValues() {
        for set in data!.dataSets {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        setNeedsDisplay()
    }

    /// Call this function will add bar borders. Call it again will remove the bar borders.
    internal func toggleBarBorders() {
        for set in data!.dataSets {
            if let set = set as? BarChartDataSet {
                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
            }
        }
        setNeedsDisplay()
    }

    /// Enable and disable the legends on the chart
    /// - parameter enable: `true` to enable, `false` to disable
    internal func toggleLegend() {
        if legend.isEnabled {
            legend.enabled = false
        } else {
            legend.enabled = true
        }
        setNeedsDisplay()
    }

    /// Enable and disable the side labels
    /// - parameter toggle: `true` to enable, `false` to disable
    internal func toggleSideLabels() {
        if rightAxis.isDrawLabelsEnabled && leftAxis.isDrawLabelsEnabled {
            rightAxis.drawLabelsEnabled = false
            leftAxis.drawLabelsEnabled = false
        } else {
            rightAxis.drawLabelsEnabled = true
            leftAxis.drawLabelsEnabled = true
        }
        setNeedsDisplay()
    }
}
