//
//  TimeSeriesTag.swift
//  PredixMobileUIKit
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// A TimeSeries tag model.
public struct SeriesData {
    
    /// Tag name
    public var name: String
    
    /// Array of data points `SeriesDataPoint`
    public var dataPoints: [SeriesDataPoint]
    
    /// Attributes are key/value pairs used to store data associated with a tag.
    public var attributes: [String : String]
    
    ///:nodoc:
    public init(name: String, dataPoints: [SeriesDataPoint], attributes: [String : String] = [:]) {
        self.name = name
        self.dataPoints = dataPoints
        self.attributes = attributes
    }
}
