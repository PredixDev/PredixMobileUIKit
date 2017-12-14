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
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet var barChartView: PredixBarChartView!
    
    var unitsBoughtBar1:Bar!
    var unitsSoldBar2:Bar!
    var unitSavedBar3:Bar!
    var months:[String]!

    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"
        months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
        let unitsBought = [10.0, 14.0, 20.0, 13.0, 2.0]
        let unitSaved = [10.0, 14.0, 20.0, 13.0, 2.0]
        
        
        unitsBoughtBar1 = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.orange])
        unitsSoldBar2 = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.gray])
        unitSavedBar3 = Bar(unitSaved, label: "Units Saved")
        barChartView.create(xAxisValues: months, bars: [unitsBoughtBar1, unitsSoldBar2,unitSavedBar3], stackBars: true, showWithDefaultAnimation: false)
        
        // By default the x axis label text color is black.
        // Below is an example on how to set the x axis label text color
        barChartView.setXAxisLabelTextColor(uiColor: NSUIColor.red)
    }

    @IBAction func optionButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Animate X", style: .default) { _ in
            self.barChartView.handleOption(.animateX)
        })
        
        alert.addAction(UIAlertAction(title: "Animte Y", style: .default) { _ in
            self.barChartView.handleOption(.animateY)
        })
        
        alert.addAction(UIAlertAction(title: "Animte XY", style: .default) { _ in
            self.barChartView.handleOption(.animateXY)
        })
        
        alert.addAction(UIAlertAction(title: "Add Bar Borders", style: .default) { _ in
            self.barChartView.handleOption(.toggleBarBorders)
        })
        
        alert.addAction(UIAlertAction(title: "Toggle Values", style: .default) { _ in
            self.barChartView.handleOption(.toggleValues)
        })
        
        alert.addAction(UIAlertAction(title: "Disable Side Labels ", style: .default) { _ in
       self.barChartView.handleOption(.disableSideLabels)
        })
        
        alert.addAction(UIAlertAction(title: "Enable Side Labels ", style: .default) { _ in
            self.barChartView.handleOption(.enableSideLabels)
        })
        
        present(alert, animated: true)
    }
    

    @IBAction func verticalLineValueChanged(_: UISlider) {
        barChartView.removeLimit()
        barChartView.addALimit(limit: Double(verticalLineSlider.value), label: "Target")
        barChartView.setNeedsDisplay()
    }

    // To enable or disable the legend
    @IBAction func enableLegendChanged(_ sender: UISwitch) {
        if sender.isOn == true {
          barChartView.handleOption(.toggleEnableLegend)
        }else{
            barChartView.handleOption(.toggleDisableLegend)
        }
    }

    @IBAction func StakedChanged(_ sender: UISwitch) {
        barChartView.stack(sender.isOn)
    }
    
}
