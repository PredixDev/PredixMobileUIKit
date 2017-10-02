//
//  TimeSeriesTag.swift
//  PredixMobileUIKit
//
//  Created by  on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

public struct TimeSeriesTag {
    public var name: String
    public var dataPoints: [TimeSeriesDataPoint]
    public var attributes: [String : String]?
    
    init(name: String, dataPoints: [TimeSeriesDataPoint], attributes: [String : String]? = nil) {
        self.name = name
        self.dataPoints = dataPoints
        self.attributes = attributes
    }
}
