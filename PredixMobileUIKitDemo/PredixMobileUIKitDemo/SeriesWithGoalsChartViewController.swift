//
//  TimeSeriesChartViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Goel, Shalab (GE Corporate) on 10/23/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import Charts

class SeriesWithGoalsChartViewController: UIViewController {

    @IBOutlet weak var chartView: PredixSeriesWithGoalsView!
    @IBOutlet weak var valuesRangeSlider: UISlider!
    @IBOutlet weak var goalLinesSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chartView.delegate = self
        self.chartView.loadLabelsAndValues(self.generateDummyData(7, numGoalLines: 2))
        
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
        let numPoints = Int(self.valuesRangeSlider.value)
        let numGoalLines = Int(self.goalLinesSlider.value)
        self.chartView.loadLabelsAndValues(self.generateDummyData(numPoints, numGoalLines: numGoalLines))
    }

    // MARK: - private functions
    private func generateDummyData(_ numPoints: Int, numGoalLines: Int) -> [SeriesData] {
        print("generating dummy data maxValue: \(numPoints), no of datasets: \(numGoalLines)")
        var data: [SeriesData] = []

        let maxValue = 250
        var date = Date()
        
//        let dateFormatter = DateFormatter()
//        let daysOfWeek = dateFormatter.shortWeekdaySymbols
//
        var dataPoints: [SeriesDataPoint] = []
        for _ in 1 ... numPoints {
            // let dayIdx = Calendar.current.component(.weekday, from: myDate)
            // let label = daysOfWeek[dayIdx]
            let label = date.timeIntervalSince1970
            let measure = Double(getRandom(50, ceiling: maxValue))
            let dataPoint = SeriesDataPoint(label:label, measure: measure)
            dataPoints.append(dataPoint)
            date = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: date, options: [])!
            print(date)
        }
        let series = SeriesData(name: "", dataPoints: dataPoints, attributes: [:])
        data.append(series)
        
        for _ in 1 ... numGoalLines {
            let goalValue = Double(getRandom(50, ceiling: maxValue))
            var goalPoints: [SeriesDataPoint] = []
            let startPoint = SeriesDataPoint(label:dataPoints[0].label, measure: goalValue)
            let endPoint   = SeriesDataPoint(label:dataPoints[dataPoints.count-1].label, measure: goalValue)
            goalPoints.append(startPoint)
            goalPoints.append(endPoint)
            
            let series = SeriesData(name: "", dataPoints: goalPoints, attributes: [:])
            data.append(series)
        }
        return data
    }
    
    private func getRandom(_ floor: Int, ceiling: Int) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound))) + floor
    }
}

extension SeriesWithGoalsChartViewController: ChartViewDelegate {
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
