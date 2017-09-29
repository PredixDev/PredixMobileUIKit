//
//  TimeSeriesDataPoint.swift
//  PredixMobileUIKit
//
//  Created by  on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

public struct TimeSeriesDataPoint {
    public var epochInMs: Double
    public var measure: Double
    public var quality: Int?
    private let defaultQuality = 3
    
    init(epochInMs: Double, measure: Double, quality: Int? = 3) {
        self.epochInMs = epochInMs
        self.measure = measure
        self.quality = defaultQuality
    }
}
