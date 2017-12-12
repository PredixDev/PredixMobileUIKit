//
//  PredixBarChartView+IBInspectable.swift
//  PredixMobileUIKit
//
//  Created by Fouche, George (GE Healthcare) on 12/10/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

extension PredixBarChartView{

    
    ///:nodoc:
open override func prepareForInterfaceBuilder(){
    super.prepareForInterfaceBuilder()
    
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]
    let bar1 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.orange])
    let bar2 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.gray])
    create(xAxisValues: months, bars: [bar1,bar2])
    
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
        get{
            return self.chartDescription?.enabled ?? false
        }
        set(newValue){
            self.chartDescription?.enabled = newValue
        }
    }
    
    @IBInspectable
    internal var legendHorizontalAlignment: Int {
        get {
            return self.legend.horizontalAlignment.rawValue
        }
        set(newValue){
            if let alignment = Legend.HorizontalAlignment(rawValue: newValue){
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
    internal var xAxisLabelPosition: Int {
        get{
            return self.xAxis.labelPosition.rawValue
        }
        set(newValue){
            if let labelPosition = XAxis.LabelPosition(rawValue:newValue){
                self.xAxis.labelPosition = labelPosition
            }
        }
    }
}
