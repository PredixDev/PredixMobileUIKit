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

// MARK: - The Option Enums

/// List of animation options that can be used on the Bar Chart.
/// Animation can be displayed on the x- or y-axis or both.
public enum BarChartAnimationOption {
    /// Animate the x-axis on the chart
    case animateX
    /// Animate the y-axis on the chart
    case animateY
    /// Animate both the x- and y-axis on the chart
    case animateXY
}

/// List of toggle options that can be used on the Bar Chart.
/// The Bar Chart legend/s, side labels, Bar values or Bar borders, can be toggled on or off.
public enum BarChartToggleOption {
    /// Toggle on or off, Bar values on the chart
    case toggleValues
    /// Toggle on or off, Bar borders on the chart
    case toggleBarBorders
    /// Toggle on or off, legend/s display on the chart
    case toggleLegend
    /// Toggle on or off, side labels on the chart
    case toggleSideLabels
}

// MARK: - The Bar Class

/// To create a Bar Chart from the `PredixBarChartView` class, the `Bar` class is used to populate each Bar data set.
public class Bar {
    /// The data the Bar holds
    public var data: [Double]
    /// The Bar label
    public var label: String
    /// The Bar colors based on the class `UIColor`
    public var colors: [UIColor] = []

    /// Initialize the data, label and colors of the Bar
    /// - parameter data: the data the bar hold
    /// - parameter label: the Bar label name
    /// - parameter colors: the Bar colors based on the class UIColor
    public init(_ data: [Double], label: String, colors: [UIColor]) {
        self.data = data
        self.label = label
        self.colors = colors
    }

    /// Initialize the data and label of the Bar.
    ///
    /// If a color is not provided a *default* color of gray is used.
    /// - parameter data: the data the bar hold
    /// - parameter label: the Bar label name
    public init(_ data: [Double], label: String) {
        self.data = data
        self.label = label
        colors = [UIColor.gray]
    }
}

// MARK: - The PredixBarChartView Class

/// PredixBarChartView -- Bar Chart
@IBDesignable
open class PredixBarChartView: BarChartView {

    // MARK: PredixBarCharView Internal Variables

    var limitLineDict = [String: ChartLimitLine]()
    var xAxisValues: [String] = []
    var bars: [Bar] = []

    // MARK: PredixBarChartView Initial Data

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

    /// Predix Mobile Bar chart initial data
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

    /// Initial x-axis
    internal func initXaxis() {
        let xaxis = xAxis
        xaxis.valueFormatter = IndexAxisValueFormatter()
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.granularity = 1
    }

    /// Initial y-axis
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

    // MARK: PredixBarChartView Adding or Removing a Limit Line

    /// Add a horizontal limit line on the Bar Chart.
    /// The line in the chart marks a certain limit on the x-axis.
    /// - parameter limitLineName: The name of the limit line.
    /// Each limit line created on the chart needs a name so it can be removed using `removeLimitLine()`.
    /// The same name is needed to remove the limit line from the chart.
    /// - parameter limit: The limit value. The value can be any decimal number. It marks a certain limit on the x-axis.
    /// - parameter label: The label name of the limit line.
    /// When the limit line is drawn on the Bar Chart, the label is displayed on top of the line.
    public func addLimitLine(limitLineName: String, limit: Double, label: String) {
        let limitLine = ChartLimitLine(limit: limit, label: label)
        limitLineDict[limitLineName] = limitLine
        rightAxis.addLimitLine(limitLine)
        setNeedsDisplay()
    }

    /// Remove the added limit line on the chart.
    /// - parameter limitLineName: The name of the limit line.
    /// Each limit lines can be removed by providing the limit line name.
    public func removeLimitLine(limitLineName: String) {

        let limitLine = limitLineDict[limitLineName]
        if limitLine != nil {
            rightAxis.removeLimitLine(limitLine!)
        }
        setNeedsDisplay()
    }

    // MARK: PredixBarChartView creating the Bar Chart Logic

    ///  Populate the Bar Chart based on each Bar data entry from the `Bar` class
    /// - parameter xAxisValues: String array of the x-axis values
    /// - parameter bars: List of Bars. Populate the Bar Chart with bar data
    /// - parameter stackBars: Optional parameter to stack or group the bars. Defaults to `true`.
    /// - parameter showWithDefaultAnimation: Optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` animation options from `changeAnimationOption()`.
    public func create(xAxisValues: [String], bars: [Bar], stackBars: Bool = true, showWithDefaultAnimation: Bool = true) {
        self.xAxisValues = xAxisValues
        self.bars = bars

        stack(stackBars)

        if showWithDefaultAnimation {
            changeAnimationOption(.animateXY)
        }
    }

    /// Stack or group the Bars on the chart
    /// - parameter stackBars: `true` to stack and `false` to group the bars display on the chart
    public func stack(_ stackBars: Bool) {
        if stackBars {
            stackBarsOnChart()
        } else {
            groupBarsOnChart()
        }
    }

    /// Create all the bar data sets from each `Bar` provided
    /// - parameter bars: List of bars that need to be displayed on the chart
    func createDataSets(bars: [Bar]) -> [BarChartDataSet] {
        var dataSets: [BarChartDataSet] = []
        for bar in bars {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0 ..< bar.data.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: bar.data[i])
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

    /// Stacks all of the Bar data sets displayed on the chart
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

    /// Groups all of the Bar data sets displayed on the chart
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
             groupSpace = (1 - numberOfBars * BarSpace) / (numberOfBars + 1)
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

    /// Change the Bar Chart animation provided from the `BarChartAnimationOption` enum
    /// - parameter animationOption: Choose one of the animation options from the `AnimationOption` enum
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

    /// Toggle on and off, different options provided from the `BarChartToggleOption` enum
    /// - parameter toggleOption: Choose one of the options from the BarChartToggleOption enum
    public func changeToggleOption(_ toggleOption: BarChartToggleOption) {
        switch toggleOption {
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

    /// Hide and show the Bar data values
    internal func toggleValues() {
        for set in data!.dataSets {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        setNeedsDisplay()
    }

    /// Hide and show the Bar borders
    internal func toggleBarBorders() {
        for set in data!.dataSets {
            if let set = set as? BarChartDataSet {
                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
            }
        }
        setNeedsDisplay()
    }

    /// Enable and disable the legends on the chart
    internal func toggleLegend() {
        if legend.isEnabled {
            legend.enabled = false
        } else {
            legend.enabled = true
        }
        setNeedsDisplay()
    }

    /// Enable and disable the side labels
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
