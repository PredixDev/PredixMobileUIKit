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
import PredixMobileSDK

class TimeSeriesChartViewController: UIViewController {

    @IBOutlet weak var tsChartView: PredixTimeSeriesView!
    @IBOutlet weak var tempratureRangeSlider: UISlider!
    @IBOutlet weak var datasetsRangeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tsChartView.delegate = self
        generateTimeSeries()
        
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
        generateTimeSeries()
    }
    
    // MARK: - private functions
    private func generateDummyData(_ maxTemp: Int, noOfDatasets: Int) -> [TimeSeriesTag] {
        print("generating dummy data maxTemp: \(maxTemp), no of datasets: \(noOfDatasets)")
        var tags: [TimeSeriesTag] = []
        let range = 8
        let upperRange = 2018
        let lowerRange = upperRange - range
        for i in 1...noOfDatasets {
            var dataPoints: [TimeSeriesDataPoint] = []
            for j in 0...range {
                let time = Double(lowerRange + j)
                let measure = Double(getRandom(50, ceiling: maxTemp))
                let dataPoint = TimeSeriesDataPoint(epochInMs: Double(time), measure: measure)
                dataPoints.append(dataPoint)
            }
            let tag = TimeSeriesTag(name: "TAG_\(i)", dataPoints: dataPoints, attributes: [:])
            tags.append(tag)
        }
        return tags
    }
    
    private func getManager() -> TimeSeriesManager {
        var config: TimeSeriesManagerConfiguration = TimeSeriesManagerConfiguration()
        
        config.baseUrl = "https://time-series-store-predix.run.aws-usw02-pr.ice.predix.io/v1/"
        
        config.predixZoneId = "6a1487bd-afb6-40b8-929c-ca872c958f74"
        
//        config.UAABaseUrl = "https://3311caf6-6548-4c24-a86c-29ee5c6acc5c.predix-uaa.run.aws-usw02-pr.ice.predix.io"
//
//        config.UAAClientId = "app_client_id"
//
//        config.UAAClientSecret = "secret"
        
        let manager: TimeSeriesManager = TimeSeriesManager(configuration: config)
        
        return manager
        
    }
    private func generateTimeSeries() {
                //Hold TimesSeries Response tags
                var responseTags: [TimeSeriesTag] = []
                //Hold TimesSeries data points
                var dataPoints: [TimeSeriesDataPoint] = []
        
                //Construct requst object for TimeSeries
                var requestTags = [Tag]()
                //Construct request tag objects
                let tag = Tag(name: "Compressor-2017:CompressionRatio", order: "desc")
                requestTags.append(tag!)
    
                let limitedDataPoints = TimeBoundDataPointsRequest(start: 1452112200000, end: 1453458897222, tags: requestTags)
        //REMOVE accessToken: After updating the latest sdk.
        let accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImxlZ2FjeS10b2tlbi1rZXkiLCJ0eXAiOiJKV1QifQ.eyJqdGkiOiJlZTlhYmY3NzkzM2M0ODIyYjNlZGQ4MmRlNTJhODA0YSIsInN1YiI6ImFwcF9jbGllbnRfaWQiLCJzY29wZSI6WyJ1YWEucmVzb3VyY2UiLCJvcGVuaWQiLCJ1YWEubm9uZSIsInRpbWVzZXJpZXMuem9uZXMuNmExNDg3YmQtYWZiNi00MGI4LTkyOWMtY2E4NzJjOTU4Zjc0LmluZ2VzdCIsInRpbWVzZXJpZXMuem9uZXMuNmExNDg3YmQtYWZiNi00MGI4LTkyOWMtY2E4NzJjOTU4Zjc0LnVzZXIiLCJ0aW1lc2VyaWVzLnpvbmVzLjZhMTQ4N2JkLWFmYjYtNDBiOC05MjljLWNhODcyYzk1OGY3NC5xdWVyeSIsInVhYS51c2VyIl0sImNsaWVudF9pZCI6ImFwcF9jbGllbnRfaWQiLCJjaWQiOiJhcHBfY2xpZW50X2lkIiwiYXpwIjoiYXBwX2NsaWVudF9pZCIsImdyYW50X3R5cGUiOiJjbGllbnRfY3JlZGVudGlhbHMiLCJyZXZfc2lnIjoiMTFhMzMwYSIsImlhdCI6MTUwODUzOTQ0OCwiZXhwIjoxNTA4NTgyNjQ4LCJpc3MiOiJodHRwczovLzMzMTFjYWY2LTY1NDgtNGMyNC1hODZjLTI5ZWU1YzZhY2M1Yy5wcmVkaXgtdWFhLnJ1bi5hd3MtdXN3MDItcHIuaWNlLnByZWRpeC5pby9vYXV0aC90b2tlbiIsInppZCI6IjMzMTFjYWY2LTY1NDgtNGMyNC1hODZjLTI5ZWU1YzZhY2M1YyIsImF1ZCI6WyJ0aW1lc2VyaWVzLnpvbmVzLjZhMTQ4N2JkLWFmYjYtNDBiOC05MjljLWNhODcyYzk1OGY3NCIsInVhYSIsIm9wZW5pZCIsImFwcF9jbGllbnRfaWQiXX0.OwrFXM0y5EEWPNM1S_Uq6ErSmBbevUHKatxaPQqVACJOC1FIKBxj66EtK3yXZEHyoLwpU-HbZTV4rmeHWpCW1ESonc9y6iFF417N3ubROFf-0fpES4GyabNJJECWjmMmFLhTQb4nE9PbBYnUBQEW3udiLgNjnV2AMyOi3F5Kn9fQHS7XCkIB5aLRrHcOI7KnJKsAmYwmRvMDgbbzURAW8skSOzbNXKXB5N9qPtIMygU4mBZEuIrxaZ0kGRiHq8IVoWs5Sx_8XkwVnMzQdknQy5K-KlTxTxX7vD9AyGf42Ea3tu8aVxANLHkwE08w7f85l6pu_t4AbzN6GmsP3cUDaA"
        //REMOVE accessToken param: After updating the latest sdk.
        getManager().timeBoundDataPoints(accessToken: accessToken, timeBoundDataPointsRequest: limitedDataPoints!, completionHandler: {(response, _) in
                //Iterate through the response tags
                for currentTag in response.tags {
                    //Iterate through the results object
                    for result in currentTag.results {
                        for values in result.values {
                            // swiftlint:disable force_cast
                            let dPoints = values as! [Double]
                             // swiftlint:enable force_cast
                            //Populate ui dataPoints
                            let dataPoint = TimeSeriesDataPoint(epochInMs: dPoints[0], measure: dPoints[1])
                            dataPoints.append(dataPoint)
                        }
                        
                    }
                    //Populate ui tags object
                    let tag = TimeSeriesTag(name: currentTag.name, dataPoints: dataPoints, attributes: [:])
                    responseTags.append(tag)
                }
        
            DispatchQueue.main.async {
                    self.tsChartView.loadLabelsAndValues(responseTags)
            }
        })
        
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
