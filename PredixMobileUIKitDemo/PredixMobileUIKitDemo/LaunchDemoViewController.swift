//
//  LaunchDemoViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Johns, Andy (GE Corporate) on 9/26/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixSDK

class LaunchDemoViewController: UITableViewController {

    struct DemoData {
        var title: String
        var description: String
        var storyboardId: String
    }

    var demos: [DemoData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Until we have more integration with PredixMobileSDK, this just ensures the frameworks are linked properly
        let predixSDKVersionInfo = PredixMobilityConfiguration.versionInfo
        print("PredixSDK Version Info: \(predixSDKVersionInfo)")
        
        self.demos = [DemoData(title: "Donut Chart", description: "Simple demonstration of a donut chart, can also be a pie chart.", storyboardId: "DonutChartDemo"),
                      DemoData(title: "TimeSeries Chart", description: "An example showcasing TimeSeries chart view usage.", storyboardId: "TimeSeriesChart"),
                      DemoData(title: "Progress Circle", description: "Demonstration of a progress circle", storyboardId: "CircleProgressDemo"),
                      DemoData(title: "Bar Chart",description: "Demonstration of a Chart Bar",storyboardId:"BarChartDemo")]
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
}

extension LaunchDemoViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = dequeueCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }

        let demoInfo = demos[indexPath.row]
        cell.textLabel?.text = demoInfo.title
        cell.detailTextLabel?.text = demoInfo.description

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let demoInfo = demos[indexPath.row]
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: demoInfo.storyboardId) {
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
}
