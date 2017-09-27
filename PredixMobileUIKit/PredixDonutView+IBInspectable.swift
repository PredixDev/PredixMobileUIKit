//
//  PredixDonutView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/22/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

//IBInspectable properties can be internal, and still show up in IB

extension PredixDonutView {
    
    open override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()

        let exampleValues: [String: Double] = [
            "IPA": 15,
            "Stout": 12,
            "Porter": 9,
            "Lambic": 8,
            "Pale Ale": 7,
            "Hefeweizen": 4,
            "Pilsner": 1,
            "Lager": 1
        ]
        loadLabelsAndValues(exampleValues, showWithDefaultAnimation: false)
        self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
    }
    
    @IBInspectable
    internal var labelText: String? {
        get {
            return self.chartDescription?.text
        }
        set(newValue) {
            self.chartDescription?.text = newValue
        }
    }
    @IBInspectable
    internal var labelEnabled: Bool {
        get {
            return self.chartDescription?.enabled ?? false
        }
        set(newValue) {
            self.chartDescription?.enabled = newValue
        }
    }
    
    @IBInspectable
    open var holeRadius: Double {
        get {
            return Double(self.holeRadiusPercent)
        }
        set{
            self.holeRadiusPercent = CGFloat(newValue)
        }
    }

    @IBInspectable
    internal var legendHorizontalAlignment: Int {
        get {
            return self.legend.horizontalAlignment.rawValue
        }
        set(newValue) {
            if let alignment = Legend.HorizontalAlignment(rawValue: newValue) {
                self.legend.horizontalAlignment = alignment
            }
        }
    }
    
    @IBInspectable
    internal var legendVerticalAlignment: Int {
        get {
            return self.legend.verticalAlignment.rawValue
        }
        set(newValue) {
            if let alignment = Legend.VerticalAlignment(rawValue: newValue) {
                self.legend.verticalAlignment = alignment
            }
        }
    }
    @IBInspectable
    internal var legendVerticalOrientation: Bool {
        get {
            return self.legend.orientation == .vertical
        }
        set(newValue) {
            if newValue {
                self.legend.orientation = .vertical
            } else {
                self.legend.orientation = .horizontal
            }
        }
    }
    @IBInspectable
    internal var legendKeyOnLeft: Bool {
        get {
            return self.legend.direction == .leftToRight
        }
        set(newValue) {
            if newValue {
                self.legend.direction = .leftToRight
            } else {
                self.legend.direction = .rightToLeft
            }
        }
    }
    
    @IBInspectable
    internal var legendAllowOverlap: Bool {
        get {
            return self.legend.drawInside
        }
        set(newValue) {
            self.legend.drawInside = newValue
        }
    }
}
