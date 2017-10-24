//
//  TimeSeriesDataPoint.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// TimeSeries data point model
public struct SeriesDataPoint {
    /// The date and time in UNIX epoch time, with millisecond precision.
    public var label: Double
    
    /// Reading (Value) Numeric
    public var measure: Double
    
    /// :nodoc: 
    public init(label: Double, measure: Double) {
        self.label = label
        self.measure = measure
    }
}
