//
//  TimeSeriesTag.swift
//  PredixMobileUIKit
//
//  Created by 212460388 on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// A TimeSeries tag model.
public struct TimeSeriesTag {
    
    /// tag name
    public var name: String
    
    /// array of data points `TimeSeriesDataPoint`
    public var dataPoints: [TimeSeriesDataPoint]
    
    /// Attributes are key/value pairs used to store data associated with a tag.
    public var attributes: [String : String]?
    
    /// :nodoc:
    public init(name: String, dataPoints: [TimeSeriesDataPoint], attributes: [String : String]? = nil) {
        self.name = name
        self.dataPoints = dataPoints
        self.attributes = attributes
    }
}
