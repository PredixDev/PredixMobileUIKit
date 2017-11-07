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

class TrendProgressChartViewController: UIViewController {

    @IBOutlet weak var chartView: PredixTrendProgressView!
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
    private func generateDummyData(_ numPoints: Int, numLimitLines: Int) -> ([ChartDataEntry], [ChartDataEntryLimitLine]) {
        self.numPointsLabel.text = "\(numPoints) Data Points Selected"
        self.limitLinesLabel.text = "\(numLimitLines) Limit Lines Selected"
        let maxValueRand = 250.0
        let minValueRand = 50.0
        var date = Date()
        date = (Calendar.current as NSCalendar).date(byAdding: .day, value: (-1 * (numPoints-1)), to: date, options: [])!
        
        var thresholdColors: [UIColor] = [self.chartView.warningThresholdColor, self.chartView.criticalThresholdColor, UIColor.Predix.green3, UIColor.Predix.blue4]
        var thresholds = [maxValueRand * 0.70, maxValueRand * 0.80]
        
        var minMeasure = maxValueRand
        var maxMeasure = minValueRand
        
        var dataPoints: [ChartDataEntry] = []
        for i in 1 ... numPoints {
            let epochInMs = 1000.0 + Double(i)
            let measure = Double(getRandom(minValueRand, ceiling: maxValueRand))
            if measure < minMeasure {
                minMeasure = measure
            }
            if measure > maxMeasure {
                maxMeasure = measure
            }
            let dataPoint = ChartDataEntry(x:epochInMs, y: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
        }
        
        var limits:[ChartDataEntryLimitLine] = []
        for idx in 1 ... numLimitLines {
            let color: UIColor = thresholdColors[idx - 1]
            let limitValue = (idx <= thresholds.count) ? thresholds[idx - 1] : maxMeasure - 20 * Double(idx-1)

            let limit = ChartDataEntryLimitLine(y: limitValue, color: color)
            limits.append(limit)
        }
        return (dataPoints, limits)
    }
    
    private func getRandom(_ floor: Double, ceiling: Double) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound)) + UInt32(floor))
    }
}

extension TrendProgressChartViewController: ChartViewDelegate {
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
