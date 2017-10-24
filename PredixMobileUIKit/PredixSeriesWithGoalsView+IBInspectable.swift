//
//  PredixTimeSeriesView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

//IBInspectable properties can be internal, and still show up in IB
extension PredixSeriesWithGoalsView {
    
    ///:nodoc:
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeWithDummyData()
        self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
    }
    
    // MARK: - private functions
    private func initializeWithDummyData() {
        
        let numPoints = 7
        let numLimitLines = 2
        
        var data: [TimeSeriesTag] = []
        var colors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
        
        let maxValue = 250
        let minValue = 50
        var date = Date()
        date = (Calendar.current as NSCalendar).date(byAdding: .day, value: (-1 * (numPoints-1)), to: date, options: [])!
        
        var dataPoints: [TimeSeriesDataPoint] = []
        for _ in 1 ... numPoints {
            let epochInMs = date.timeIntervalSince1970
            let measure = Double(getRandom(minValue, ceiling: maxValue))
            let dataPoint = TimeSeriesDataPoint(epochInMs:epochInMs, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        let series = TimeSeriesTag(name: "", dataPoints: dataPoints)
        data.append(series)
        
        var limits:[TimeSeriesLimitLine] = []
        for idx in 1 ... numLimitLines {
            let limitValue = Double(getRandom(minValue, ceiling: maxValue))
            let color: UIColor = colors[idx % colors.count]
            let limit = TimeSeriesLimitLine(measure:limitValue, color:color)
            limits.append(limit)
        }
        
        loadLabelsAndValues(data, limits:limits)
    }
    
    private func getRandom(_ floor: Int, ceiling: Int) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound))) + floor
    }
    
    // MARK: - IBInspectable properties
    
//    @IBInspectable
//    var labelText: String? {
//        get {
//            return self.chartDescription?.text
//        }
//        set(newValue) {
//            self.chartDescription?.text = newValue
//        }
//    }
//    
//    @IBInspectable
//    var labelEnabled: Bool {
//        get {
//            return chartDescription?.enabled ?? false
//        }
//        set(newValue) {
//            chartDescription?.enabled = newValue
//        }
//        
//    }
//    
//    @IBInspectable
//    var legendVerticalOrientation: Bool {
//        get {
//            return self.legend.orientation == .vertical
//        }
//        set(newValue) {
//            if newValue {
//                self.legend.orientation = .vertical
//            } else {
//                self.legend.orientation = .horizontal
//            }
//        }
//    }
//    
//    @IBInspectable var leftAxisEnabled: Bool {
//        get {
//            return leftAxis.enabled
//        }
//        set(newValue) {
//            leftAxis.enabled = newValue
//        }
//    }
//    
//    @IBInspectable
//    var rightAxisEnabled: Bool {
//        get {
//            return rightAxis.enabled
//        }
//        set(newValue) {
//            rightAxis.enabled = newValue
//        }
//    }
//    
    @IBInspectable
    var xAxisDateFormat: String? {
        get {
            return self.horizontalDateFormat
        }
        set(newValue) {
            self.horizontalDateFormat = newValue!
        }
    }
    
    @IBInspectable
    var yAxisNumberFormat: String? {
        get {
            return self.verticalNumberFormat
        }
        set(newValue) {
            self.verticalNumberFormat = newValue
        }
    }
    
    @IBInspectable
    var seriesFillColor: UIColor? {
        get {
            return self.fillColor ?? .lightGray
        }
        set(newValue) {
            self.fillColor = newValue
        }
    }
 
}
