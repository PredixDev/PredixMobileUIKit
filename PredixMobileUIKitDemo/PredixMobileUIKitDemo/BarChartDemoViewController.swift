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
    
  

    override func viewDidLoad() {
        title = "Unit Bought vs Units Sold"
        let months = ["Jan", "Feb", "Mar", "Apr", "May"]
        let unitsSold = [20.0, 4.0, 2.0, 5.0, 12.0]
        let unitsBought = [10.0, 2.0, 6.0, 3.0, 5.0]
        
        let  unitsSoldBar  = Bar(unitsSold, label: "Units Sold", colors: [NSUIColor.gray])
        let unitsBoughtBar = Bar(unitsBought, label: "Units Bought", colors: [NSUIColor.orange])
        barChartView.create(xAxisValues: months, bars:[unitsSoldBar,unitsBoughtBar], stackBars: true, showWithDefaultAnimation: false)
        

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
