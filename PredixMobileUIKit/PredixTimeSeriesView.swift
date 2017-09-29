//
//  PredixTimeSeriesView.swift
//  PredixMobileUIKit
//
//  Created by 212460388 (GE Digital) on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

@IBDesignable
open class PredixTimeSeriesView: LineChartView {
    
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override open func setNeedsDisplay() {
        if self.data != nil {
            self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
        }
        super.setNeedsDisplay()
    }
    
    // MARK:- public functions
    /// Helper function to populate the chart based on timeseries array
    public func loadLabelsAndValues(with tags: [TimeSeriesTag]) -> Void {
        var dataSets: [LineChartDataSet] = []
        var colorCounter: Int = 0
        for tag in tags {
            var dataEntries:[ChartDataEntry] = []
            for dataPoint in tag.dataPoints {
                let dataEntry: ChartDataEntry = ChartDataEntry(x: dataPoint.epochInMs, y: dataPoint.measure) //quality can be shown as an image
                dataEntries.append(dataEntry)
            }
            colorCounter += 1
            
            let dataSet:LineChartDataSet = LineChartDataSet(values: dataEntries, label: tag.name)
            dataSet.lineWidth = 1.5;
            dataSet.circleRadius = 4.0;
            dataSet.circleHoleRadius = 2.0;
            
            let color:UIColor = self.dataVisualizationColors[colorCounter % dataVisualizationColors.count]
//            let color:UIColor = colors[colorCounter % colors.count]
            dataSet.setColor(color)
            dataSet.setCircleColor(color)
            dataSet.colors = [color]
            dataSet.circleColors = [.red]
            dataSets.append(dataSet)
        }
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 7))
        
        self.data = data;
    }
    
    // MARK:- fileprivate functions
    /// Predix Mobile Donut chart initial values
    fileprivate func initialize() {
        self.backgroundColor? = .white
        self.leftAxis.enabled = true
        self.rightAxis.enabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.xAxis.enabled = true
        
        self.drawBordersEnabled = true
        self.dragEnabled = true
        self.setScaleEnabled(true)
        self.pinchZoomEnabled = true
        
        let l:Legend = self.legend;
        l.horizontalAlignment = .left;
        l.verticalAlignment = .top;
        l.orientation = .horizontal;
        l.drawInside = false;
        
//        setXAxisTags()
        
    }
    
    fileprivate func setXAxisTags() {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        self.xAxis.granularity = 1
        self.xAxis.centerAxisLabelsEnabled = true
        self.xAxis.labelRotationAngle = -90
    }
    
}
