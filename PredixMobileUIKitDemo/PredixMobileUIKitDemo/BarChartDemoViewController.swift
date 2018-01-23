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

    @IBOutlet var horizontalSlider: UISlider!
    @IBOutlet var enabledLegendSwitch: UISwitch!
    @IBOutlet var optionsButton: UIButton!
    @IBOutlet var displayToggle: UISwitch!
    @IBOutlet var barBorderSwitch: UISwitch!

    @IBOutlet var barChartView: PredixBarChartView!

    let limitLinelabel = "Target"

    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"
        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 2.0, 5.0, 12.0]
        let unitsBought = [10.0, 2.0, 6.0, 3.0, 5.0]

        let unitsSoldBar = Bar(unitsSold, label: "Units Sold", colors: [UIColor.gray])
        let unitsBoughtBar = Bar(unitsBought, label: "Units Bought", colors: [UIColor.orange])
        barChartView.create(xAxisValues: months, bars: [unitsSoldBar, unitsBoughtBar], stackBars: true, showWithDefaultAnimation: false)
        barBorderSwitch.setOn(false, animated: false)
        displayToggle.setOn(false, animated: false)
    }

    @IBAction func optionButtonTapped(_: UIButton) {
        let alert = UIAlertController(title: "Bart Chart Animations", message: "Choose an animation", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Animate X", style: .default) { _ in
            self.barChartView.changeAnimationOption(.animateX)
        })

        alert.addAction(UIAlertAction(title: "Animte Y", style: .default) { _ in
            self.barChartView.changeAnimationOption(.animateY)
        })

        alert.addAction(UIAlertAction(title: "Animte XY", style: .default) { _ in
            self.barChartView.changeAnimationOption(.animateXY)
        })
        present(alert, animated: true)
    }

    @IBAction func horizontalValueChanged(_: UISlider) {
        displayToggle.setOn(true, animated: false)
        barChartView.removeLimitLine(lineName: "George")
        barChartView.addLimitLine(lineName: "George", limit: Double(horizontalSlider.value), label: limitLinelabel)
    }

    // To enable or disable the legend
    @IBAction func enableLegendChanged(_: UISwitch) {
        barChartView.changeToggleOption(.toggleLegend)
    }

    @IBAction func sideLabelsChanged(_: UISwitch) {
        barChartView.changeToggleOption(.toggleSideLabels)
    }

    @IBAction func valuesChanged(_: UISwitch) {
        barChartView.changeToggleOption(.toggleValues)
    }

    @IBAction func stakedChanged(_ sender: UISwitch) {
        barChartView.stack(sender.isOn)
    }

    @IBAction func enableBarBordersChanged(_: UISwitch) {
        barChartView.changeToggleOption(.toggleBarBorders)
    }

    @IBAction func enableLimitLineChanged(_ sender: UISwitch) {
        print(sender.isOn)
        if sender.isOn {
            barChartView.addLimitLine(lineName: "George", limit: Double(horizontalSlider.value), label: limitLinelabel)
        } else {
            barChartView.removeLimitLine(lineName: "George")
        }
    }
}
