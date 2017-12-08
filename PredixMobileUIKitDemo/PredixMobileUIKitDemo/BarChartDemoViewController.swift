//
//  BarChartDemoViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Fouche, George (GE Healthcare) on 11/15/17.
//  Copyright © 2017 GE. All rights reserved.
//
import Charts
import Foundation
import PredixMobileUIKit
import UIKit

class BarchartDemoViewController: UIViewController {

    @IBOutlet var barChartView: PredixBarChartView!
    var months: [String]!
    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsBought, label: "Units Bought", color: [NSUIColor.orange])
        let bar2 = Bar(unitsSold, label: "Units Sold", color: [NSUIColor.gray])

        barChartView.create(xAxisValues: months, bars: [bar1, bar2], stackBars: true, showWithDefaultAnimation: true)

        // Add a limit line
        barChartView.addALimit(limit: 10.0, label: "Target")

        /// By default the legend horizontal alignment is set to right and the vertical alignment is set to top.
        /// Below is an example of  how the legend can be position differently
        barChartView.legend.horizontalAlignment = .left
        barChartView.legend.verticalAlignment = .top

        // To enable or disable the legend
        barChartView.legend.enabled = true

        // By default the x axis label text color is black.
        // Below is an example on how to set the x axis label text color
        barChartView.setXAxisLabelTextColor(uiColor: NSUIColor.red)

        // By default tje x axis label position is set to bottom
        // Below is an example o how to change the x xais position
        barChartView.xAxis.labelPosition = .bottom
    }
}
