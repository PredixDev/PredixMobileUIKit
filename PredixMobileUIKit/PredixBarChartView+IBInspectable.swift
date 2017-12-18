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

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]
        let bar1 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.orange])
        let bar2 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.gray])
        create(xAxisValues: months, bars: [bar1, bar2])
    }

    // MARK: - IBInspectable properties

    /// the chart embedded label text
    @IBInspectable
    internal var labelText: String? {
        get {
            return chartDescription?.text
        }
        set(newValue) {
            chartDescription?.text = newValue
        }
    }

    // enable or disable the chart message embedded label text
    @IBInspectable
    internal var labelEnabled: Bool {
        get {
            return chartDescription?.enabled ?? false
        }
        set(newValue) {
            chartDescription?.enabled = newValue
        }
    }

    /// the chart message when there's not data
    @IBInspectable
    internal var noDataMessage: String {
        get {
            return noDataText
        }
        set(newValue) {
            noDataText = newValue
        }
    }

    /// indicates whether the legend chart should be aligned on the left *default:* true
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

    /// indicates whether the legend chart should be aligned on the bottom *default:* true
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

    /// indicates whether the legend chart should be orientated vertically *default:* true
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

    /// the chart boarder color *default: * white
    @IBInspectable
    open var chartBorderColor: UIColor {
        get {
            return borderColor
        }
        set(newValue) {
            borderColor = newValue
        }
    }

    /// the chart x axis text color *default:* black
    @IBInspectable
    open var xAxisTextColor: UIColor {
        get {
            return xAxis.labelTextColor
        }
        set(newValue) {
            xAxis.labelTextColor = newValue
        }
    }

    /// the legend chart x axis text color *default:* black
    @IBInspectable
    open var legendTextColor: UIColor {
        get {
            return legend.textColor
        }
        set(newValue) {
            legend.textColor = newValue
        }
    }

    /// text color to display when there is no chart data loaded *default:* black
    @IBInspectable
    open var noChartDataTextColor: UIColor {
        set(newValue) {
            noDataTextColor = newValue
        } get {
            return noDataTextColor
        }
    }
}
