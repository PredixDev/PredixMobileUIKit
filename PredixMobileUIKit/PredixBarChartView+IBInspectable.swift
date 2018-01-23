//
//  PredixBarChartView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by Fouche, George (GE Healthcare) on 12/10/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Charts
import Foundation

extension PredixBarChartView {

    /// :nodoc:
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 2.0, 5.0, 12.0]
        let unitsBought = [10.0, 2.0, 6.0, 3.0, 5.0]

        let unitsSoldBar = Bar(unitsSold, label: "Units Sold", colors: [UIColor.gray])
        let unitsBoughtBar = Bar(unitsBought, label: "Units Bought", colors: [UIColor.orange])
        create(xAxisValues: months, bars: [unitsSoldBar, unitsBoughtBar], stackBars: true, showWithDefaultAnimation: false)
    }

    // MARK: - IBInspectable properties

    /// The chart embedded label text
    @IBInspectable
    internal var labelText: String? {
        get {
            return chartDescription?.text
        }
        set(newValue) {
            chartDescription?.text = newValue
        }
    }

    // Enable or disable the chart message embedded label text
    @IBInspectable
    internal var labelEnabled: Bool {
        get {
            return chartDescription?.enabled ?? false
        }
        set(newValue) {
            chartDescription?.enabled = newValue
        }
    }

    /// The chart message when there's no data
    @IBInspectable
    internal var noDataMessage: String {
        get {
            return noDataText
        }
        set(newValue) {
            noDataText = newValue
        }
    }

    /// Indicates whether the legend chart should be aligned on the left.
    //
    /// The *default* value is true.
    @IBInspectable
    internal var legendAlignedLeft: Bool {
        get {
            return legend.horizontalAlignment == .left
        }
        set(newValue) {
            if newValue {
                legend.horizontalAlignment = .left
            } else {
                legend.horizontalAlignment = .right
            }
        }
    }

    /// Indicates whether the legend chart should be aligned on the bottom.
    //
    /// The *default* value is true.
    @IBInspectable
    internal var legendAlignedOnBottom: Bool {
        get {
            return legend.verticalAlignment == .bottom
        }
        set(newValue) {
            if newValue {
                legend.verticalAlignment = .bottom
            } else {
                legend.verticalAlignment = .top
            }
        }
    }

    /// Indicates whether the legend chart should be orientated vertically.
    //
    /// The *default* value is true.
    @IBInspectable
    internal var legendOrientationVertical: Bool {
        get {
            return legend.orientation == .vertical
        }
        set(newValue) {
            if newValue {
                legend.orientation = .vertical
            } else {
                legend.orientation = .horizontal
            }
        }
    }

    /// The chart x axis text color.
    //
    /// The *default* value is black.
    @IBInspectable
    open var xAxisTextColor: UIColor {
        get {
            return xAxis.labelTextColor
        }
        set(newValue) {
            xAxis.labelTextColor = newValue
        }
    }

    /// The legend chart x axis text color.
    //
    /// The *default* value is black.
    @IBInspectable
    open var legendTextColor: UIColor {
        get {
            return legend.textColor
        }
        set(newValue) {
            legend.textColor = newValue
        }
    }

    /// The text color to display when there is no chart data loaded.
    //
    /// The *default* value is black.
    @IBInspectable
    open var noChartDataTextColor: UIColor {
        set(newValue) {
            noDataTextColor = newValue
        } get {
            return noDataTextColor
        }
    }
}
