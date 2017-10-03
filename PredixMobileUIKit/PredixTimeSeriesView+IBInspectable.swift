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
    
    /// :nodoc
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
            let tag = TimeSeriesTag(name: "TAG_\(i)", dataPoints: dataPoints, attributes: nil)
            tags.append(tag)
        }
        loadLabelsAndValues(tags)
    }
    
    // MARK: - IBInspectable properties
    
    @IBInspectable
    var labelText: String? {
        get {
            return self.chartDescription?.text
        }
        set(newValue) {
            self.chartDescription?.text = newValue
        }
    }
    
    @IBInspectable
    var labelEnabled: Bool {
        get {
            return chartDescription?.enabled ?? false
        }
        set(newValue) {
            chartDescription?.enabled = newValue
        }
        
    }
    
    @IBInspectable
    var legendVerticalOrientation: Bool {
        get {
            return self.legend.orientation == .vertical
        }
        set(newValue) {
            if newValue {
                self.legend.orientation = .vertical
            } else {
                self.legend.orientation = .horizontal
            }
        }
    }
    
    @IBInspectable var leftAxisEnabled: Bool {
        get {
            return leftAxis.enabled
        }
        set(newValue) {
            leftAxis.enabled = newValue
        }
    }
    
    @IBInspectable
    var rightAxisEnabled: Bool {
        get {
            return rightAxis.enabled
        }
        set(newValue) {
            rightAxis.enabled = newValue
        }
    }
    
    @IBInspectable
    var legendAlignedLeft: Bool {
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
    var legendAlignedTop: Bool {
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
 
}
