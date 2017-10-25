//
//  SeriesWithLimitsChartViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import Charts

class SeriesWithLimitsChartViewController: UIViewController {

    @IBOutlet weak var chartView: PredixSeriesWithLimitsView!
    @IBOutlet weak var numPointsSlider: UISlider!
    @IBOutlet weak var limitLinesSlider: UISlider!
    @IBOutlet weak var numPointsLabel: UILabel!
    @IBOutlet weak var limitLinesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chartView.delegate = self
        
        let (data, limits) = self.generateDummyData(7, numLimitLines: 2)
        self.chartView.loadLabelsAndValues(data, limits:limits)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sliderValueChanged(_ sender: Any) {
        let numPoints = Int(self.numPointsSlider.value)
        let numLimitLines = Int(self.limitLinesSlider.value)
        let (data, limits) = self.generateDummyData(numPoints, numLimitLines: numLimitLines)
        self.chartView.loadLabelsAndValues(data, limits:limits)
    }

    // MARK: - private functions
    private func generateDummyData(_ numPoints: Int, numLimitLines: Int) -> ([TimeSeriesTag], [TimeSeriesLimitLine]) {
        var data: [TimeSeriesTag] = []
        
        var colors: [UIColor] = UIColor.Predix.DataVisualizationSets.regular
        
        self.numPointsLabel.text = "\(numPoints) Data Points Selected"
        self.limitLinesLabel.text = "\(numLimitLines) Limit Lines Selected"
        let maxValueRand = 250.0
        let minValueRand = 50.0
        var date = Date()
        date = (Calendar.current as NSCalendar).date(byAdding: .day, value: (-1 * (numPoints-1)), to: date, options: [])!
        
        var minMeasure = maxValueRand
        var maxMeasure = minValueRand
        
        var dataPoints: [TimeSeriesDataPoint] = []
        for _ in 1 ... numPoints {
            let epochInMs = date.timeIntervalSince1970
            let measure = Double(getRandom(minValueRand, ceiling: maxValueRand))
            if measure < minMeasure {
                minMeasure = measure
            }
            if measure > maxMeasure {
                maxMeasure = measure
            }
            let dataPoint = TimeSeriesDataPoint(epochInMs:epochInMs, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        let series = TimeSeriesTag(name: "", dataPoints: dataPoints)
        data.append(series)
        
        var limits:[TimeSeriesLimitLine] = []
        for idx in 1 ... numLimitLines {
            let color: UIColor = colors[idx % colors.count]
            let limitValue = maxMeasure - 20 * Double(idx-1)

            let limit = TimeSeriesLimitLine(measure:limitValue, color:color)
            limits.append(limit)
        }
        return (data, limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
}

extension SeriesWithLimitsChartViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("chartScaled")
    }
    
    func chartTranslated(_ chartView: ChartViewBase, pointX: CGFloat, pointY: CGFloat) {
        print("chartTranslated")
    }
}
