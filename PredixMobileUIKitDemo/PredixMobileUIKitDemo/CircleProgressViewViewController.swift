//
//  ProgressCircleDemoViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Johns, Andy (GE Corporate) on 10/6/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import PredixMobileUIKit

class CircleProgressViewViewController: UIViewController {
    var progressLabelBase = ""
    var criticalLabelBase = ""
    var warningLabelBase = ""
    var scaleViewLabelBase = ""
    var scaleTitleLabelBase = ""
    var tholdLineLengthLabelBase = ""
    var tholdLineWidthLabelBase = ""
    var progressLineLabelBase = ""
    var circleLineLabelBase = ""
    
    @IBOutlet var invertThresholds: UISwitch!
    @IBOutlet var counterClockwise: UISwitch!
    @IBOutlet var hideTitle: UISwitch!
    @IBOutlet var animateTitle: UISwitch!
    @IBOutlet var adaptProgressColor: UISwitch!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var scaleViewLabel: UILabel!
    @IBOutlet var scaleTitleLabel: UILabel!
    @IBOutlet var criticalTholdLabel: UILabel!
    @IBOutlet var warningTholdLabel: UILabel!
    @IBOutlet var tholdLineLengthLabel: UILabel!
    @IBOutlet var tholdLineWidthLabel: UILabel!
    @IBOutlet var progressLineLabel: UILabel!
    @IBOutlet var circleLineLabel: UILabel!
    @IBOutlet var progressViewWidth: NSLayoutConstraint!
    @IBOutlet var progressViewHeight: NSLayoutConstraint!
    
    @IBOutlet var scaleViewSlider: UISlider!
    @IBOutlet var titleScaleFactorSlider: UISlider!
    @IBOutlet var criticalTholdSlider: UISlider!
    @IBOutlet var warningTholdSlider: UISlider!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var progressView: PredixCircleProgressView!
    @IBOutlet var tholdLineLengthSlider: UISlider!
    @IBOutlet var tholdLineWidthSlider: UISlider!
    @IBOutlet var progressLineSlider: UISlider!
    @IBOutlet var circleLineSlider: UISlider!
    override var canBecomeFirstResponder: Bool  { return true }
    
    override func viewDidLoad() {
        progressLabelBase = progressLabel.text ?? ""
        criticalLabelBase = criticalTholdLabel.text ?? ""
        warningLabelBase = warningTholdLabel.text ?? ""
        scaleViewLabelBase = scaleViewLabel.text ?? ""
        scaleTitleLabelBase = scaleTitleLabel.text ?? ""
        tholdLineLengthLabelBase = tholdLineLengthLabel.text ?? ""
        tholdLineWidthLabelBase = tholdLineWidthLabel.text ?? ""
        progressLineLabelBase = progressLineLabel.text ?? ""
        circleLineLabelBase = circleLineLabel.text ?? ""
    }
    

    override func viewDidAppear(_ animated: Bool) {
        loadDefaults()
        progressSliderChanged(progressSlider)
        criticalTholdSliderChanged(criticalTholdSlider)
        warningTholdSliderChanged(warningTholdSlider)
        titleScaleFactorSliderChanged(titleScaleFactorSlider)
        tholdLineLengthSliderChanged(tholdLineLengthSlider)
        tholdLineWidthSliderChanged(tholdLineWidthSlider)
        progressLineSliderChanged(progressLineSlider)
        circleLineSliderChanged(circleLineSlider)
        progressView.animateProgress(to: progressView.progress)
    }
    
    func loadDefaults() {
        progressSlider.value = Float(progressView.progress)
        criticalTholdSlider.value = Float(progressView.criticalThreshold)
        warningTholdSlider.value = Float(progressView.warningThreshold)
        titleScaleFactorSlider.value = Float(progressView.titleScaleFactor)
        tholdLineLengthSlider.value = Float(progressView.thresholdLineLength)
        tholdLineWidthSlider.value = Float(progressView.thresholdLineWidth)
        progressLineSlider.value = Float(progressView.progressLineWidth)
        circleLineSlider.value = Float(progressView.circleLineWidth)
        scaleViewSlider.value = Float(progressViewHeight.constant)
        
        invertThresholds.isOn = progressView.invertThresholds
        counterClockwise.isOn = progressView.counterClockwise
        hideTitle.isOn = progressView.isTitleHidden
        animateTitle.isOn = progressView.isTitleAnimated
        adaptProgressColor.isOn = progressView.thresholdColorMatching
    }
    
    @IBAction func progressSliderMoveComplete(_ sender: UISlider) {
        progressSliderChanged(progressSlider)
        progressView.animateProgress(to: CGFloat(sender.value))
    }
    
    @IBAction func progressSliderChanged(_ sender: UISlider) {
        updatePercent(label: self.progressLabel, base: self.progressLabelBase, value: CGFloat(sender.value))
    }
    
    @IBAction func adaptProgressColorChanged(_ sender: UISwitch) {
        self.progressView.thresholdColorMatching = sender.isOn
        self.progressView.setNeedsDisplay()
    }
    
    @IBAction func animateTitleChanged(_ sender: UISwitch) {
        self.progressView.isTitleAnimated = sender.isOn
    }
    @IBAction func hideTitleChanged(_ sender: UISwitch) {
        self.progressView.isTitleHidden = sender.isOn
        self.progressView.setNeedsDisplay()
    }
    
    @IBAction func resizeProgressViewSliderChanged(_ sender: UISlider) {
        let newConstant = CGFloat(sender.value)
        self.progressViewHeight.constant = newConstant
        self.progressViewWidth.constant = newConstant
        self.progressView.setNeedsUpdateConstraints()
        self.progressView.setNeedsDisplay()
    }
    
    @IBAction func criticalTholdSliderChanged(_ sender: UISlider) {
        progressView.criticalThreshold = CGFloat(sender.value)
        updatePercent(label: self.criticalTholdLabel, base: self.criticalLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }
    @IBAction func warningTholdSliderChanged(_ sender: UISlider) {
        progressView.warningThreshold = CGFloat(sender.value)
        updatePercent(label: self.warningTholdLabel, base: self.warningLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }
    @IBAction func titleScaleFactorSliderChanged(_ sender: UISlider) {
        progressView.titleScaleFactor = CGFloat(sender.value)
        updateFloat(label: self.scaleTitleLabel, base: self.scaleTitleLabelBase, value: CGFloat(sender.value))
    }
    
    @IBAction func tholdLineLengthSliderChanged(_ sender: UISlider) {
        progressView.thresholdLineLength = CGFloat(sender.value)
        update(label: self.tholdLineLengthLabel, base: self.tholdLineLengthLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }
    
    @IBAction func tholdLineWidthSliderChanged(_ sender: UISlider) {
        progressView.thresholdLineWidth = CGFloat(sender.value)
        update(label: self.tholdLineWidthLabel, base: self.tholdLineWidthLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }

    @IBAction func circleLineSliderChanged(_ sender: UISlider) {
        progressView.circleLineWidth = CGFloat(sender.value)
        update(label: self.circleLineLabel, base: self.circleLineLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }
    @IBAction func progressLineSliderChanged(_ sender: UISlider) {
        progressView.progressLineWidth = CGFloat(sender.value)
        update(label: self.progressLineLabel, base: self.progressLineLabelBase, value: CGFloat(sender.value))
        progressView.setNeedsDisplay()
    }
    
    @IBAction func invertThresholdsChanged(_ sender: UISwitch) {
        progressView.invertThresholds = sender.isOn
    }
    
    @IBAction func counterClockwiseChanged(_ sender: UISwitch) {
        progressView.counterClockwise = sender.isOn
    }
    
    func update(label: UILabel, base: String, value: CGFloat) {
        let text = String(format: "\(base) %.0f%", value)
        label.text = text
        label.setNeedsDisplay()
    }
    
    func updatePercent(label: UILabel, base: String, value: CGFloat) {
        let text = String(format: "\(base) %.0f%%", value * 100)
        label.text = text
        label.setNeedsDisplay()
    }
    
    func updateFloat(label: UILabel, base: String, value: CGFloat) {
        let text = String(format: "\(base) %.2f%", value)
        label.text = text
        label.setNeedsDisplay()
    }

}
