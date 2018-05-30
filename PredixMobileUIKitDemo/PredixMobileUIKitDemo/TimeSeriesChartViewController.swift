//
//  TimeSeriesChartViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by 212460388 on 10/3/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import Charts

class TimeSeriesChartViewController: UIViewController {

    @IBOutlet weak var tsChartView: PredixTimeSeriesView!
    @IBOutlet weak var tempratureRangeSlider: UISlider!
    @IBOutlet weak var datasetsRangeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tsChartView.delegate = self
        self.tsChartView.load(dataSets: self.generateDummyData(80, noOfDatasets: 2))
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
        let tempratureMax = Int(self.tempratureRangeSlider.value)
        let maxDatasets = Int(self.datasetsRangeSlider.value)
        self.tsChartView.load(dataSets: self.generateDummyData(tempratureMax, noOfDatasets: maxDatasets))
    }
    
    // MARK: - private functions
    private func generateDummyData(_ maxTemp: Int, noOfDatasets: Int) -> [LineChartDataSet] {
        print("generating dummy data maxTemp: \(maxTemp), no of datasets: \(noOfDatasets)")
        var tags: [LineChartDataSet] = []
        let range = 8
        let upperRange = 2018
        let lowerRange = upperRange - range
        var colorCounter: Int = 0
        for setNdx in 1...noOfDatasets {
            var dataPoints: [ChartDataEntry] = []
            for index in 0...range {
                let time = Double(lowerRange + index)
                let measure = Double(arc4random_uniform(UInt32(maxTemp)))
                dataPoints.append(ChartDataEntry(x: time, y: measure, data: NSNumber(value: 3)))
            }
            colorCounter += 1
            
            let dataSet = LineChartDataSet(values: dataPoints, label: "TAG_\(setNdx)")
            dataSet.lineCapType = .round
            dataSet.mode = .horizontalBezier
            dataSet.lineWidth = 1.5
            dataSet.circleRadius = 0.0
            
            let color: UIColor = UIColor.Predix.DataVisualizationSets.regular[colorCounter % UIColor.Predix.DataVisualizationSets.regular.count]
            dataSet.setColor(color)
            dataSet.setCircleColor(color)
            dataSet.colors = [color]
            dataSet.circleColors = [.red]
            tags.append(dataSet)
        }
        
        return tags
    }
    
    private func getRandom(_ floor: Int, ceiling: Int) -> Int {
        let upperBound = ceiling - floor + 1
        return Int(arc4random_uniform(UInt32(upperBound))) + floor
    }
}

extension TimeSeriesChartViewController: ChartViewDelegate {
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
