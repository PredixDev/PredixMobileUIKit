//
//  PredixTimeSeriesView.swift
//  PredixMobileUIKit
//
//  Created by 212460388 (GE Digital) on 9/28/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import Charts
import PredixSDK

/// PredixTimeSeriesView -- TimeSeries chart built with `LineChartView`.
@IBDesignable
open class PredixTimeSeriesView: LineChartView {
    ///A delegate to allow a class to know when it's time to load data into the view
    @IBOutlet
    open weak var timeSeriesDataDelegate: TimeSeriesViewDelegate? {
        didSet {
            
            /*if let dataFunction = timeSeriesDataDelegate?.loadTimeSeriesData {
                self.showSpinner()
                dataFunction { (tags) in
                    Utilities.runOnMainThread {
                        self.loadLabelsAndValues(tags: tags ?? [])
                        self.hideSpinner()
                    }
                }
            } else*/ if let dataFunction = timeSeriesDataDelegate?.loadTimeSeriesTags { //<-- Will return once the Timeseries refactoring is complete
                self.showSpinner()
                dataFunction { (tags) in
                    Utilities.runOnMainThread {
                        self.loadLabelsAndValues(timeSeriesTags: tags ?? [])
                        self.hideSpinner()
                    }
                }
            }
        }
    }
    /// set the color scheme to dark *default:* false
    @IBInspectable
    open var darkTheme: Bool = false {
        didSet {
            if darkTheme {
                self.backgroundColor = UIColor(hue: 51.0/255.0, saturation: 51.0/255.0, brightness: 51.0/255.0, alpha: 1.0)
                self.chartBorderColor = UIColor.white
                self.xAxisTextColor = UIColor.white
                self.rightAxisTextColor = UIColor.white
                self.leftAxisTextColor = UIColor.white
                self.legendTextColor = UIColor.white
                self.noChartDataTextColor = UIColor.white
            } else {
                self.backgroundColor = UIColor.clear
                self.chartBorderColor = UIColor.black
                self.xAxisTextColor = UIColor.black
                self.leftAxisTextColor = UIColor.black
                self.rightAxisTextColor = UIColor.black
                self.legendTextColor = UIColor.black
                self.noChartDataTextColor = UIColor.black
            }
        }
    }
    
    /// the data point font *default:* System font with system font size
    open var dataPointFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    ///Allows a developer to set some basic padding for the chart legend labels *Default 10.0*
    open var legendLabelPadding: CGFloat = 10.0
    
    /// Array of colors to use. Defaults to UIColor.Predix.DataVisualizationSets.regular
    open var dataVisualizationColors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
    internal let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    internal let grayView = UIView()
    
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
    public func loadLabelsAndValues(timeSeriesTags: [TimeSeriesTag]) {
        var dataSets: [LineChartDataSet] = []
        var colorCounter: Int = 0
        for tag in timeSeriesTags {
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
        data.setValueFont(dataPointFont)
        self.data = data
        self.notifyDataSetChanged()
        self.setNeedsLayout()
        
    }
    ///Loads data from a TimeseriesManager response
//    public func loadLabelsAndValues(tags: [Tag]) { //<-- Will return once the Timeseries refactoring is complete
//        var responseTags: [TimeSeriesTag] = []
//        var dataPoints: [TimeSeriesDataPoint] = []
//
//        for currentTag in tags {
//            for result in currentTag.results {
//                for values in result.values {
//                    if let dPoints = values as? [Double] {
//                        let dataPoint = TimeSeriesDataPoint(epochInMs: dPoints[0], measure: dPoints[1])
//                        dataPoints.append(dataPoint)
//                    }
//                }
//
//            }
//            let tag = TimeSeriesTag(name: currentTag.name, dataPoints: dataPoints, attributes: [:])
//            responseTags.append(tag)
//        }
//
//        self.loadLabelsAndValues(timeSeriesTags: responseTags)
//    }
    /// :nodoc:
    open override func layoutSubviews() {
        super.layoutSubviews()
        activityView.frame = self.bounds
        grayView.frame = self.bounds
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
        let fullyScreenResizeMask: UIViewAutoresizing = [.flexibleBottomMargin, .flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        grayView.autoresizingMask = fullyScreenResizeMask
        activityView.autoresizingMask = fullyScreenResizeMask
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
/// :nodoc:
extension PredixTimeSeriesView: ChartViewDelegate {
    /// :nodoc:
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.timeSeriesDataDelegate?.valueSelected?(timeSeriesView: self, timeScale: highlight.x)
    }
}
///A delegate to allow a class to know when it's time to load data into the view
@objc public protocol TimeSeriesViewDelegate {
    ///Will be called to ask to load time series data based on the TimeSeriesTag object
    @objc optional func loadTimeSeriesTags(completionHandler: @escaping ([TimeSeriesTag]?) -> Void)
    ///Will be called to ask to load time series data based on the TimeSeriesManager Tag object
//    @objc optional func loadTimeSeriesData(completionHandler: @escaping ([Tag]?) -> Void) //<-- Will return once the Timeseries refactoring is complete
    ///Notifies a delegate when an item on a chart is selected by the user
    @objc optional func valueSelected(timeSeriesView: PredixTimeSeriesView, timeScale: Double)
}