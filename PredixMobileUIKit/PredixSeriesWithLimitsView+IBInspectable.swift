//
//  PredixSeriesWithLimitsView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

//IBInspectable properties can be internal, and still show up in IB
extension PredixSeriesWithLimitsView {
    
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
        
        let maxValueRand = 250.0
        let minValueRand = 50.0
        var date = Date()
        date = (Calendar.current as NSCalendar).date(byAdding: .day, value: (-1 * (numPoints-1)), to: date, options: [])!
        
        var minMeasure = maxValueRand
        var maxMeasure = minValueRand
        
        var dataPoints: [TimeSeriesDataPoint] = []
        for _ in 1 ... numPoints {
            let epochInMs = date.timeIntervalSince1970
            let measure = Double(getRandom(minValueRand, ceiling: maxValueRand))
            if measure < minMeasure {
                minMeasure = measure
            }
            if measure > maxMeasure {
                maxMeasure = measure
            }
            let dataPoint = TimeSeriesDataPoint(epochInMs:epochInMs, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        let series = TimeSeriesTag(name: "", dataPoints: dataPoints)
        data.append(series)
        
        var limits:[TimeSeriesLimitLine] = []
        for idx in 1 ... numLimitLines {
            let color: UIColor = colors[idx % colors.count]
            let limitValue = maxMeasure - 20 * Double(idx-1)
            
            let limit = TimeSeriesLimitLine(measure:limitValue, color:color)
            limits.append(limit)
        }
        
        loadLabelsAndValues(data, limits:limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
    
    // MARK: - IBInspectable properties
    
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
    var seriesFillColor: UIColor? {
        get {
            return self.fillColor ?? .lightGray
        }
        set(newValue) {
            self.fillColor = newValue
        }
    }
 
}
