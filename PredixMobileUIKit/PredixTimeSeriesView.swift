//
//  PredixTimeSeriesView.swift
//  PredixMobileUIKit
//
//  Created by 212460388 (GE Digital) on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts

/// PredixTimeSeriesView -- TimeSeries chart built with `LineChartView`.
@IBDesignable
open class PredixTimeSeriesView: LineChartView {
    
    @IBInspectable @IBOutlet
    open var timeSeriesDataDelegate: PredixTimeSeriesViewDelegate? {
        didSet {
            if let dataFunction = timeSeriesDataDelegate?.loadTimeSeriesData {
                self.showSpinner()
                dataFunction { (tags) in
                    DispatchQueue.main.async {
                        self.loadLabelsAndValues(tags ?? [])
                        self.hideSpinner()
                    }                    
                }
            }
        }
    }
    
    //Allows a developer to set some basic padding for the chart legend labels *Default 10.0*
    open var legendLabelPadding: CGFloat = 10.0
    
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    internal var dataFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private let grayView = UIView()
    
    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - public functions
    
    /// Helper function to populate the timeseries chart based on timeseries tags array.
    /// - parameter tags: Array of `TimeSeriesTag`.
    public func loadLabelsAndValues(_ tags: [TimeSeriesTag]) {
        var dataSets: [LineChartDataSet] = []
        var colorCounter: Int = 0
        for tag in tags {
            var dataEntries: [ChartDataEntry] = []
            for dataPoint in tag.dataPoints {
                let dataEntry: ChartDataEntry = ChartDataEntry(x: dataPoint.epochInMs, y: dataPoint.measure) //quality can be shown as an image
                dataEntries.append(dataEntry)
            }
            colorCounter += 1
            
            let dataSet: LineChartDataSet = LineChartDataSet(values: dataEntries, label: tag.name)
            dataSet.lineCapType = .round
            dataSet.mode = .horizontalBezier
            dataSet.lineWidth = 1.5
            dataSet.circleRadius = 0.0
            
            let color: UIColor = self.dataVisualizationColors[colorCounter % dataVisualizationColors.count]
            dataSet.setColor(color)
            dataSet.setCircleColor(color)
            dataSet.colors = [color]
            dataSet.circleColors = [.red]
            dataSets.append(dataSet)
        }
        
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(NSUIColor.white)
        data.setValueFont(dataFont)
        self.data = data
        self.notifyDataSetChanged()
        self.setNeedsLayout()
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        activityView.frame = self.bounds
        grayView.frame = self.bounds
        activityView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        let highlight = self.lastHighlighted ?? Highlight(x: 0, y: 0, xPx: 0, yPx: 0, dataIndex: 0, dataSetIndex: 0, stackIndex: 0, axis: .left)
        self.highlightValue(highlight, callDelegate: true)
        if self.data != nil {
            self.legend.calculateDimensions(labelFont: self.legend.font, viewPortHandler: self.viewPortHandler)
            var paddedSizes = [CGSize]()
            for size in self.legend.calculatedLabelSizes {
                let newSize = CGSize(width: size.width + legendLabelPadding, height: size.height)
                paddedSizes.append(newSize)
            }
            self.legend.calculatedLabelSizes = paddedSizes
        }
    }
    
    // MARK: - fileprivate functions
    
    /// Predix Mobile Donut chart initial values
    fileprivate func initialize() {
        self.backgroundColor? = .clear
        self.borderColor = .black
        self.leftAxis.enabled = true
        self.rightAxis.enabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.xAxis.enabled = true
        
        self.drawBordersEnabled = true
        self.dragEnabled = true
        self.setScaleEnabled(true)
        self.pinchZoomEnabled = true
        
        self.clipValuesToContentEnabled = true
        
        let l: Legend = self.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .line
        l.font = UIFont.systemFont(ofSize: 16)
        l.formSize = 16
        l.formLineWidth = 5
        
        delegate = self
        
        grayView.backgroundColor = .black
        grayView.alpha = 0.5
        addSubview(activityView)
    }
    
    private func showSpinner() {
        guard !subviews.contains(grayView) else {
            return
        }
        
        self.isUserInteractionEnabled = false
        self.insertSubview(grayView, belowSubview: activityView)
        self.activityView.startAnimating()
    }
    
    private func hideSpinner() {
        grayView.removeFromSuperview()
        self.activityView.stopAnimating()
        self.isUserInteractionEnabled = true
    }
    
}

extension PredixTimeSeriesView: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let datasets = self.data?.dataSets {
            for (index, dataset) in datasets.enumerated() {
                let entry = dataset.entriesForXValue(highlight.x).first
                if let label = dataset.label, let value = entry?.y {
                    self.legend.entries[index].label = "\(label): \(value)"
                }
            }
        }
        
        self.timeSeriesDataDelegate?.valueSelected?(timeSeriesView: self, timeScale: highlight.x)
    }
}

@objc public protocol PredixTimeSeriesViewDelegate {
    @objc optional func loadTimeSeriesData(completionHandler: @escaping ([TimeSeriesTag]?)->Void)
    @objc optional func valueSelected(timeSeriesView: PredixTimeSeriesView, timeScale: Double)
}
