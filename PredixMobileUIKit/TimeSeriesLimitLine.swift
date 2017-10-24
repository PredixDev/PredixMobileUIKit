//
//  TimeSeriesDataPoint.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// TimeSeries limit line model
public struct TimeSeriesLimitLine {
    /// Reading (Value) Numeric
    public var measure: Double
    
    /// color for line to be drawn.
    public var color: UIColor
    
    /// :nodoc:
    public init(measure: Double, color: UIColor) {
        self.measure = measure
        self.color = color
    }
}
