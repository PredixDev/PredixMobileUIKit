//
//  PredixTimeSeriesView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by 212460388 (GE Digital) on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

//IBInspectable properties can be internal, and still show up in IB
extension PredixTimeSeriesView {
    
    ///:nodoc:
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeWithDummyData()
        self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
    }
    
    // MARK: - private functions
    private func initializeWithDummyData() {
        var tags: [TimeSeriesTag] = []
        let range = 8
        let upperRange = 2018
        let lowerRange = upperRange - range
        for i in 1...3 {
            var dataPoints: [TimeSeriesDataPoint] = []
            for j in 0...range {
                let time = Double(lowerRange + j)
                let measure = Double((arc4random_uniform(UInt32(115)) + UInt32(50)) )
                let dataPoint = TimeSeriesDataPoint(epochInMs: Double(time), measure: measure, quality: 3)
                dataPoints.append(dataPoint)
            }
            let tag = TimeSeriesTag(name: "TAG_\(i)", dataPoints: dataPoints, attributes: [:])
            tags.append(tag)
        }
        loadLabelsAndValues(timeSeriesTags: tags)
    }
    
    // MARK: - IBInspectable properties
    /// the chart embedded label text
    @IBInspectable
    open var labelText: String? {
        get {
            return chartDescription?.text
        }
        set(newValue) {
            chartDescription?.text = newValue
        }
    }
    
    @IBInspectable
    /// indicates whether the chats embedded label should be displayed *default:* false
    open var labelEnabled: Bool {
        get {
            return chartDescription?.enabled ?? false
        }
        set(newValue) {
            chartDescription?.enabled = newValue
        }
        
    }
    /// indicates whether left axis label should be displayed *default:* true
    @IBInspectable open var leftAxisEnabled: Bool {
        get {
            return leftAxis.enabled
        }
        set(newValue) {
            leftAxis.enabled = newValue
        }
    }
    /// indicates whether right axis label should be displayed *default:* true
    @IBInspectable open var rightAxisEnabled: Bool {
        get {
            return rightAxis.enabled
        }
        set(newValue) {
            rightAxis.enabled = newValue
        }
    }
    /// indicates whether legend chart should be displayed vertically *default:* true
    @IBInspectable open var legendVerticalOrientation: Bool {
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
    /// indicates whether legend chart should be aligned on the left *default:* true
    @IBInspectable
    open var legendAlignedLeft: Bool {
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
    
    @IBInspectable
    /// indicates whether legend chart should be aligned on the top *default:* true
    open var legendAlignedTop: Bool {
        get {
            return legend.verticalAlignment == .top
        }
        set(newValue) {
            if newValue {
                legend.verticalAlignment = .top
            } else {
                legend.verticalAlignment = .bottom
            }
        }
    }
    /// the chart boarder color *default:* white
    @IBInspectable
    open var chartBorderColor: UIColor {
        get {
            return borderColor
        }
        set(newValue) {
            borderColor = newValue
        }
    }
    /// the chart x Axis text color *default:* black
    @IBInspectable
    open var xAxisTextColor: UIColor {
        get {
            return xAxis.labelTextColor
        }
        set(newValue) {
            xAxis.labelTextColor = newValue
        }
    }
    /// the right chart x Axis text color *default:* black
    @IBInspectable
    open var rightAxisTextColor: UIColor {
        get {
            return rightAxis.labelTextColor
        }
        set(newValue) {
            rightAxis.labelTextColor = newValue
        }
    }
    /// the left chart x Axis text color *default:* black
    @IBInspectable
    open var leftAxisTextColor: UIColor {
        get {
            return leftAxis.labelTextColor
        }
        set(newValue) {
            leftAxis.labelTextColor = newValue
        }
    }
    /// the legend chart x Axis text color *default:* black
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
            self.noDataTextColor = newValue
        } get {
            return self.noDataTextColor
        }
    }
}
