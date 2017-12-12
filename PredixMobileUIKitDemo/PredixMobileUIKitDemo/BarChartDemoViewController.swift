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

    @IBOutlet var vertTopButton: UIButton!
    @IBOutlet var vertBottomButton: UIButton!
    @IBOutlet var horzRightButton: UIButton!
    @IBOutlet var horzLeftButton: UIButton!
    @IBOutlet var verticalLineSlider: UISlider!
    @IBOutlet var enabledLegendSwitch: UISwitch!

    @IBOutlet var stackBarSwitch: UISwitch!
    @IBOutlet var labelPosTop: UIButton!
    @IBOutlet var labelPosTopInside: UIButton!
    @IBOutlet var labelPosBottom: UIButton!
    @IBOutlet var labelPosBottomInside: UIButton!

    @IBOutlet var barChartView: PredixBarChartView!
    var months: [String]!

    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [10.0, 2.0, 20.0, 4.0, 5, 8.0, 9.0, 15.0, 1.0, 3.0, 10.0, 18.0]

        let bar1 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.orange])
        let bar2 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.gray])

        barChartView.create(xAxisValues: months, bars: [bar1, bar2], stackBars: true, showWithDefaultAnimation: true)

        // By default the x axis label text color is black.
        // Below is an example on how to set the x axis label text color
        barChartView.setXAxisLabelTextColor(uiColor: NSUIColor.red)

        // By default the x axis label position is set to bottom
        // Below is an example o how to change the x xais position
        barChartView.xAxis.labelPosition = .bottomInside
        
    }

    /// Below is an example of how the legend can be position differently
    /// By default the legend horizontal alignment is set to right and the vertical alignment is set to top.
    @IBAction func horzButtonTapped(_ sender: UIButton) {
        vertTopButton.isSelected = false
        vertBottomButton.isSelected = false
        horzRightButton.isSelected = false
        horzLeftButton.isSelected = false
        sender.isSelected = true

        switch sender {
        case horzLeftButton:
            barChartView.legend.horizontalAlignment = .left
        case horzRightButton:
            barChartView.legend.horizontalAlignment = .right
        case vertTopButton:
            barChartView.legend.verticalAlignment = .top
        case vertBottomButton:
            barChartView.legend.verticalAlignment = .bottom
        default:
            break
        }
        barChartView.setNeedsDisplay()
    }

    @IBAction func labelPosButtonTapped(_ sender: UIButton) {
        labelPosBottom.isSelected = false
        labelPosTop.isSelected = false
        labelPosTopInside.isSelected = false
        labelPosBottomInside.isSelected = false
        sender.isSelected = true

        switch sender {
        case labelPosTop:
            barChartView.xAxis.labelPosition = .top
        case labelPosTopInside:
            barChartView.xAxis.labelPosition = .topInside
        case labelPosBottom:
            barChartView.xAxis.labelPosition = .bottom
        case labelPosBottomInside:
            barChartView.xAxis.labelPosition = .bottomInside
        default:
            break
        }
        barChartView.setNeedsDisplay()
    }

    @IBAction func verticalLineValueChanged(_: UISlider) {
        barChartView.removeLimit()
        barChartView.addALimit(limit: Double(verticalLineSlider.value), label: "Target")
        barChartView.setNeedsDisplay()
    }

    // To enable or disable the legend
    @IBAction func enableLegendChanged(_ sender: UISwitch) {
        barChartView.legend.enabled = sender.isOn
        barChartView.setNeedsDisplay()
    }

    @IBAction func stackBarChanged(_: UISwitch) {
    }
}
