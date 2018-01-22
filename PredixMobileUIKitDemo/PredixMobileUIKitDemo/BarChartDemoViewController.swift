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

    @IBOutlet var verticalLineSlider: UISlider!
    @IBOutlet var enabledLegendSwitch: UISwitch!
    @IBOutlet var optionsButton: UIButton!
    @IBOutlet var displayToggle: UISwitch!
    @IBOutlet var barChartView: PredixBarChartView!

    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"
        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 2.0, 5.0, 12.0]
        let unitsBought = [10.0, 2.0, 6.0, 3.0, 5.0]

        let unitsSoldBar = Bar(unitsSold, label: "Units Sold", colors: [UIColor.gray])
        let unitsBoughtBar = Bar(unitsBought, label: "Units Bought", colors: [UIColor.orange])
        barChartView.create(xAxisValues: months, bars: [unitsSoldBar, unitsBoughtBar], stackBars: true, showWithDefaultAnimation: false)
    }

    @IBAction func optionButtonTapped(_: UIButton) {
        let alert = UIAlertController(title: "Bart Chart Animations", message: "Choose an animation", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Animate X", style: .default) { _ in
            self.barChartView.handleOption(.animateX)
        })

        alert.addAction(UIAlertAction(title: "Animte Y", style: .default) { _ in
            self.barChartView.handleOption(.animateY)
        })

        alert.addAction(UIAlertAction(title: "Animte XY", style: .default) { _ in
            self.barChartView.handleOption(.animateXY)
        })
        present(alert, animated: true)
    }

    @IBAction func verticalLineValueChanged(_: UISlider) {
        displayToggle.setOn(true, animated: false)
        barChartView.removeLimitLine()
        barChartView.addLimitLine(limit: Double(verticalLineSlider.value), label: "Target")
    }

    // To enable or disable the legend
    @IBAction func enableLegendChanged(_ sender: UISwitch) {
        if sender.isOn {
            barChartView.handleOption(.enableLegend)
        } else {
            barChartView.handleOption(.disableLegend)
        }
    }

    @IBAction func sideLabelsChanged(_ sender: UISwitch) {
        if sender.isOn {
            barChartView.handleOption(.enableSideLabels)
        } else {
            barChartView.handleOption(.disableSideLabels)
        }
    }

    @IBAction func valuesChanged(_: UISwitch) {
        barChartView.handleOption(.toggleValues)
    }

    @IBAction func stakedChanged(_ sender: UISwitch) {
        barChartView.stack(sender.isOn)
    }

    @IBAction func enableBarBordersChanged(_: UISwitch) {
        barChartView.handleOption(.toggleBarBorders)
    }

    @IBAction func enableLimitLineChanged(_ sender: UISwitch) {
        print(sender.isOn)
        barChartView.displayLimitLine(sender.isOn)
    }
}
