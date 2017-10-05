//
//  ViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Johns, Andy (GE Corporate) on 9/15/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import Charts

class DonutChartDemoViewController: UIViewController {

    @IBOutlet var vertTopButton: UIButton!
    @IBOutlet var vertCenterButton: UIButton!
    @IBOutlet var vertBottomButton: UIButton!

    @IBOutlet var horzLeftButton: UIButton!
    @IBOutlet var horzCenterButton: UIButton!
    @IBOutlet var horzRightButton: UIButton!

    @IBOutlet var horzOrientation: UIButton!
    @IBOutlet var vertOrientation: UIButton!

    @IBOutlet var holeSizeSlider: UISlider!

    @IBOutlet var donut: PredixDonutView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        holeSizeSlider.minimumValue = -0.1
        holeSizeSlider.maximumValue = 0.98
        holeSizeSlider.value = Float(donut.holeRadiusPercent)

        let values: [String: Double] = [
            "IPA": 3,
            "Stout": 15,
            "Porter": 9,
            "Lambic": 8,
            "Pale Ale": 7,
            "Hefeweizen": 4,
            "Pilsner": 1,
            "Lager": 1
        ]
        donut.loadLabelsAndValues(values)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func vertButtonTapped(_ sender: UIButton) {
        vertTopButton.isSelected = false
        vertCenterButton.isSelected = false
        vertBottomButton.isSelected = false
        sender.isSelected = true

        switch sender {
        case vertTopButton:
            donut.legend.verticalAlignment = .top
        case vertCenterButton:
            donut.legend.verticalAlignment = .center
        case vertBottomButton:
            donut.legend.verticalAlignment = .bottom
        default:
            break
        }

        donut.setNeedsDisplay()
    }

    @IBAction func horzButtonTapped(_ sender: UIButton) {
        horzLeftButton.isSelected = false
        horzCenterButton.isSelected = false
        horzRightButton.isSelected = false
        sender.isSelected = true

        switch sender {
        case horzLeftButton:
            donut.legend.horizontalAlignment = .left
        case horzCenterButton:
            donut.legend.horizontalAlignment = .center
        case horzRightButton:
            donut.legend.horizontalAlignment = .right
        default:
            break

        }

        donut.setNeedsDisplay()
    }

    @IBAction func orientationButtonTapped(_ sender: UIButton) {
        vertOrientation.isSelected = false
        horzOrientation.isSelected = false
        sender.isSelected = true

        donut.legend.orientation = sender == vertOrientation ? .vertical : .horizontal

        donut.setNeedsDisplay()

    }
    @IBAction func sliderChanged(_ sender: UISlider) {

        if holeSizeSlider.value < 0.0 {
            donut.drawHoleEnabled = false
        } else {
            donut.drawHoleEnabled = true
            donut.holeRadiusPercent = CGFloat(holeSizeSlider.value)
        }
        donut.setNeedsDisplay()

    }
}
