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
    /// A delegate to allow a class to know when it's time to load data into the view
    @IBOutlet
    open weak var timeSeriesDataDelegate: TimeSeriesViewDelegate?
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
    
    /// Allows a developer to set some basic padding for the chart legend labels *Default 10.0*
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
    
    /// Loads Time Series data into the chart view using the data from a DataPointResponse obtained from the PredixSDK
    open func load(dataPointResponse: DataPointResponse) {
        if let dataPoints = dataPointResponse.dataPoints {
            self.load(tagDataPoints: dataPoints)
        }
    }
    
    /// Loads Time Series data into the chart view using the data from an array of TagDataPoint obtained from the PredixSDK
    open func load(tagDataPoints: [TagDataPoint]) {
        var dataSets: [LineChartDataSet] = []
        var colorCounter: Int = 0
        for dataPoint in tagDataPoints {
            colorCounter += 1
            var dataEntries = [ChartDataEntry]()
            
            //when the new version of the SDK is release we can flatten the model structure so we don't have to do an n^2 loop to load the values
            if let dataPointResults = dataPoint.results {
                for dataPointResult in dataPointResults {
                    if let values = dataPointResult.values {
                        for dataPointValue in values {
                            dataEntries.append(ChartDataEntry(x: Double(dataPointValue.timestamp), y: dataPointValue.measure, data: NSNumber(value: dataPointValue.quality.rawValue)))
                        }
                    }
                }
            }
            
            let dataSet: LineChartDataSet = LineChartDataSet(values: dataEntries, label: dataPoint.tagName)
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
        
        self.load(dataSets: dataSets)
    }
    
    open func load(dataSets: [LineChartDataSet]) {
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(NSUIColor.white)
        data.setValueFont(dataPointFont)
        self.data = data
        self.notifyDataSetChanged()
        self.setNeedsLayout()
    }

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
    
    // MARK: - private functions
    
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
        self.timeSeriesDataDelegate?.valueSelected(timeSeriesView: self, timeScale: highlight.x)
    }
}
///A delegate to allow a class to know when it's time to load data into the view
@objc public protocol TimeSeriesViewDelegate {
    ///Notifies a delegate when an item on a chart is selected by the user
    func valueSelected(timeSeriesView: PredixTimeSeriesView, timeScale: Double)
}
