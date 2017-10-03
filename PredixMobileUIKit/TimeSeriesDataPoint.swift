//
//  TimeSeriesDataPoint.swift
//  PredixMobileUIKit
//
//  Created by  on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// TimeSeries data point model
public struct TimeSeriesDataPoint {
    /// The date and time in UNIX epoch time, with millisecond precision.
    public var epochInMs: Double
    
    /// Reading (Value) Numeric
    public var measure: Double
    
    /// Quality of the data, represented by the values 0, 1, 2, 3. Defaults to 3 if not provided.
    public var quality: Int?

    private let defaultQuality = 3
    
    /// :nodoc: 
    public init(epochInMs: Double, measure: Double, quality: Int? = 3) {
        self.epochInMs = epochInMs
        self.measure = measure
        self.quality = defaultQuality
    }
}
