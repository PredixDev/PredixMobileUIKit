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
        let numGoalLines = 2
        
        print("generating dummy data maxValue: \(numPoints), no of datasets: \(numGoalLines)")
        var data: [SeriesData] = []
        
        let maxValue = 250
        var date = Date()
        
//        let dateFormatter = DateFormatter()
//        let daysOfWeek = dateFormatter.shortWeekdaySymbols
        
        var dataPoints: [SeriesDataPoint] = []
        for _ in 1 ... numPoints {
            // let dayIdx = Calendar.current.component(.weekday, from: myDate)
            // let label = daysOfWeek[dayIdx]
            let label = date.timeIntervalSince1970
            let measure = Double(getRandom(50, ceiling: maxValue))
            let dataPoint = SeriesDataPoint(label:label, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        let series = SeriesData(name: "", dataPoints: dataPoints, attributes: [:])
        data.append(series)
        
        for _ in 1 ... numGoalLines {
            let goalValue = Double(getRandom(50, ceiling: maxValue))
            var goalPoints: [SeriesDataPoint] = []
            let startPoint = SeriesDataPoint(label:dataPoints[0].label, measure: goalValue)
            let endPoint   = SeriesDataPoint(label:dataPoints[dataPoints.count-1].label, measure: goalValue)
            goalPoints.append(startPoint)
            goalPoints.append(endPoint)
            
            let series = SeriesData(name: "", dataPoints: goalPoints, attributes: [:])
            data.append(series)
        }
        
        loadLabelsAndValues(data)
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
//    @IBInspectable
//    var legendAlignedLeft: Bool {
//        get {
//            return legend.horizontalAlignment == .left
//        }
//        set(newValue) {
//            if newValue {
//                legend.horizontalAlignment = .left
//            } else {
//                legend.horizontalAlignment = .right
//            }
//        }
//        
//    }
//    
//    @IBInspectable
//    var legendAlignedTop: Bool {
//        get {
//            return legend.verticalAlignment == .top
//        }
//        set(newValue) {
//            if newValue {
//                legend.verticalAlignment = .top
//            } else {
//                legend.verticalAlignment = .bottom
//            }
//        }
//    }
 
}
