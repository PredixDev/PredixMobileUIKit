//
//  PMDonut.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/15/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts
import PredixSDK

/// PredixDonutView -- Donut view chart, also can be a pie chart.
@IBDesignable
open class PredixDonutView: PieChartView {

    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular

    ///:nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    ///:nodoc:
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /// Predix Mobile Donut chart initial values
    fileprivate func initialize() {
        self.holeRadiusPercent = 0.9
        self.drawHoleEnabled = true
        self.drawEntryLabelsEnabled = false
        self.usePercentValuesEnabled = false
        self.legend.horizontalAlignment = .right
        self.legend.verticalAlignment = .top
        self.chartDescription?.enabled = false
    }

    /// Helper function to populate the chart based on simple key/value pairs
    /// - parameter labelsAndValues: Dictionary of labels (key) and values
    /// - parameter showWithDefaultAnimation: optional parameter to show the chart with the default animation. Defaults to `true`. If `false` the caller is responsible for calling one of the `animate` methods to provide custom display animation.
    public func loadLabelsAndValues(_ labelsAndValues: [String: Double], showWithDefaultAnimation: Bool = true) {

        var values: [PieChartDataEntry] = []
        for (label, value) in labelsAndValues {
            values.append(PieChartDataEntry(value: value, label: label))
        }

        let dataSet = PieChartDataSet(values: values, label: nil)
        dataSet.colors = self.dataVisualizationColors

        let chartData = PieChartData(dataSet: dataSet)
        self.data = chartData

        if showWithDefaultAnimation {
            self.animate(xAxisDuration: 1.4, easingOption: .easeInOutBack)
        }
    }

    ///:nodoc:
    override open func setNeedsDisplay() {
        if self.data != nil {
            self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
        }
        super.setNeedsDisplay()
    }

    // Used in unit testing
    // Until we have more integration with PredixSDK, this just ensures the frameworks are linked properly
    internal func predixSDKVersion() -> String {
        let predixSDKVersionInfo = PredixSDK.Utilities.versionInfo
        print("\(#function) PredixSDK Version Info: \(predixSDKVersionInfo)")
        return predixSDKVersionInfo
    }

}
