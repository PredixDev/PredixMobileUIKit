//
//  PredixCircleProgressView.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 10/6/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import UIKit

/// Progress Circle View
/// Shows progress as an arc within a circular display
/// Can display two threshold lines, and change the progress color when the progress passes those thresholds
/// Can display the percentage progress value as a centered title
/// Can animate changes to the progress arc, the threshold color change, and title updates
@IBDesignable
open class PredixCircleProgressView: UIView {
    
    // MARK: Internal constants
    
    internal let progressAnimationKey = "progress_animation"
    internal let colorAnimationKey = "color_animation"
    
    // MARK: public properties
    
    /// Progress value, from 0 to 1
    @IBInspectable
    public var progress: CGFloat = 0.0 {
        didSet {
            if isAnimating() {
                cancelAnimation()
            }
            progressLayer.progress = progress
            updateTitle(to: progress)
            adjustPerceivedProgressColor()
        }
    }
    
    /// Controls whether or not the title text will show within the progress circle.
    @IBInspectable
    public var isTitleHidden: Bool {
        get {
            return self.title.isHidden
        }
        set(newValue) {
            self.title.isHidden = newValue
        }
    }
    
    /// Controls whether or not the title text will animate with progress display.
    @IBInspectable
    public var isTitleAnimated: Bool = true
    
    /// Format string for the title text
    @IBInspectable
    public var titleFormat: String = "%.0f%%"
    
    /// Value to multiply the progress value by before formatting for the title display
    public var titleProgessMultiplier: CGFloat = 100.0

    ///Color used for the incomplete portion of the progress display
    @IBInspectable
    public var circleColor: UIColor = UIColor.gray {
        didSet {
            progressLayer.circleColor = circleColor
        }
    }
    
    /// Progress circle color
    @IBInspectable
    public var progressColor: UIColor = UIColor.green {
        didSet {
            progressLayer.progressColor = progressColor
        }
    }
    
    /// Warning threshold color
    @IBInspectable
    public var warningThresholdColor: UIColor = UIColor.orange {
        didSet {
            progressLayer.warningThresholdColor = warningThresholdColor
        }
    }
    
    /// Critical threshold color
    @IBInspectable
    public var criticalThresholdColor: UIColor = UIColor.red {
        didSet {
            progressLayer.criticalThresholdColor = criticalThresholdColor
        }
    }
    
    ///When true, the color of the progress circle will change to match the crossed threshold
    @IBInspectable
    public var thresholdColorMatching: Bool = true {
        didSet {
            if !thresholdColorMatching {
                perceivedProgressColor = progressColor
                progressLayer.colorCorrection = nil
                updateProgressLayer()
            } else {
                adjustPerceivedProgressColor()
            }
        }
    }
    
    /// Warning threshold
    /// Set to zero to disable warning thresholds
    @IBInspectable
    public var warningThreshold: CGFloat = 0.00 {
        didSet {
            progressLayer.warningThreshold = warningThreshold
            updateProgressLayer()
            adjustPerceivedProgressColor()
        }
    }
    
    /// Critical threshold
    /// Set to zero to disable critical thresholds
    @IBInspectable
    public var criticalThreshold: CGFloat = 0.00 {
        didSet {
            progressLayer.criticalThreshold = criticalThreshold
            updateProgressLayer()
            adjustPerceivedProgressColor()
        }
    }
    
    /// Length of the threshhold lines
    /// Set to zero to disable visible threshold lines
    @IBInspectable
    public var thresholdLineLength: CGFloat = 20 {
        didSet {
            progressLayer.thresholdLineLength = thresholdLineLength
            updateProgressLayer()
        }
    }
    
    /// Witdh of the threshhold lines
    @IBInspectable
    public var thresholdLineWidth: CGFloat = 1.0 {
        didSet {
            progressLayer.thresholdLineWidth = thresholdLineWidth
            updateProgressLayer()
        }
    }
    
    /// Factor to scale the title text relative to the progress circle size
    @IBInspectable
    public var titleScaleFactor: CGFloat = 0.4 {
        didSet {
            createtitleSizeConstraints()
        }
    }

    /// Line width of the progress circle
    @IBInspectable
    public var progressLineWidth: CGFloat = 10.0 {
        didSet {
            progressLayer.progressLineWidth = progressLineWidth
            self.createtitleSizeConstraints()
            updateProgressLayer()
        }
    }

    /// Line width of the incomplete circle
    @IBInspectable
    public var circleLineWidth: CGFloat = 10.0 {
        didSet {
            progressLayer.circleLineWidth = circleLineWidth
            createtitleSizeConstraints()
            updateProgressLayer()
        }
    }
    
    /// Draw the progress arc counterclockwise rather than clockwise
    /// Defaults to false, which uses a clockwise arc.
    @IBInspectable
    public var counterClockwise: Bool = false {
        didSet {
            progressLayer.counterClockwise = counterClockwise
            updateProgressLayer()
        }
    }
    
    /// Consider thresholds minimums rather than maximums.
    /// If true then thresholds are crossed when the progress is below the threshold
    /// Defaults to false, thresholds are crossed when the progress is above the threshold
    @IBInspectable
    public var invertThresholds: Bool = false {
        didSet {
            self.perceivedProgressColor = progressLayer.progressColor
            updateProgressLayer()
            self.adjustPerceivedProgressColor()
        }
    }
    
    /// Total duration used to animate progress from 0 to 100%.
    /// Actual duration of progress animation will be dependant on the value change.
    public var progressAnimationDuration: CFTimeInterval = 1.5 {
        didSet {
            progressLayer.clicks = self.clickDuration
        }
    }

    /// Title Label
    public var title: UILabel! {
        didSet {
            initializeTitleLabel(title)
        }
    }

    // MARK: private properties
    internal var animationsEnabled = false // we don't need animations until the UI is displayed

    private var clickDuration: CFTimeInterval { return progressAnimationDuration / 360.0 }
    
    private var perceivedProgressColor: UIColor! {
        didSet {
            progressLayer.progressColor = perceivedProgressColor
        }
    }
    
    private var progressLayer: CircleProgressLayer {
        guard let progressLayer = layer as? CircleProgressLayer else {
            assert(false, "layer not expected type")
            return CircleProgressLayer(layer: layer)
        }
        return progressLayer
    }
    
    private var titleHeightConstraint: NSLayoutConstraint?
    private var titleWidthConstraint: NSLayoutConstraint?
    
    // MARK: UIView overrides
    
    /// :nodoc:
    open override class var layerClass: AnyClass {
        return CircleProgressLayer.self
    }
    
    /// :nodoc:
    open override func didMoveToWindow() {
        layer.contentsScale = self.window?.screen.scale ?? layer.contentsScale
        animationsEnabled = true
    }
    
    /// :nodoc:
    override open func setNeedsDisplay() {
        super.setNeedsDisplay()
        updateProgressLayer()
    }
    
    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialization()
    }

    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    /// :nodoc:
    open override func awakeFromNib() {
        super.awakeFromNib()
        adjustPerceivedProgressColor()
        animationsEnabled = true
    }
    
    /// :nodoc:
    open override func prepareForInterfaceBuilder() {
        animationsEnabled = false
        self.initializeLayerValues(self.progressLayer)
        self.adjustPerceivedProgressColor()
        self.layer.setNeedsDisplay()
    }
    
    /// :nodoc:
    override open func setNeedsUpdateConstraints() {
        self.createtitleSizeConstraints()
    }
    
    // MARK: private methods
    private func createtitleSizeConstraints() {

        if let heightConstraint = self.titleHeightConstraint {
            self.title.removeConstraint(heightConstraint)
            self.removeConstraint(heightConstraint)
        }
        if let widthConstraint = self.titleWidthConstraint {
            self.title.removeConstraint(widthConstraint)
            self.removeConstraint(widthConstraint)
        }
        
        self.titleWidthConstraint = self.title.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(self.titleScaleFactor))
        self.titleHeightConstraint = self.title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: CGFloat(self.titleScaleFactor))

        // shrink by 1.5 times the line width of the circle on each side (1.5 * 2 = 3.0). This places the title text just within the circle.
        self.titleWidthConstraint?.constant = max(self.circleLineWidth, self.progressLineWidth) * -3.0
        self.titleHeightConstraint?.constant = max(self.circleLineWidth, self.progressLineWidth) * -3.0
        
        self.titleWidthConstraint?.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
        self.titleHeightConstraint?.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)

        self.titleWidthConstraint?.isActive = true
        self.titleHeightConstraint?.isActive = true
        super.setNeedsUpdateConstraints()
    }
    
    private func initialization() {

        self.perceivedProgressColor = progressColor
        self.title = UILabel()
        self.initializeLayerValues(self.progressLayer)
        self.layer.setNeedsDisplay()
    }
    
    private func initializeTitleLabel(_ label: UILabel) {
        
        self.addSubview(title)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        title.font = title.font.withSize(100)
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.1
        
        title.textAlignment = .center
        title.baselineAdjustment = .alignCenters
        title.adjustsFontForContentSizeCategory = true
        title.allowsDefaultTighteningForTruncation = true
        title.numberOfLines = 1
        title.isUserInteractionEnabled = false
        
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        createtitleSizeConstraints()
    }
    
    private func initializeLayerValues(_ layer: CircleProgressLayer) {
        
        layer.colorCorrection = nil
        layer.clicks = self.clickDuration
        layer.progressColor = self.progressColor
        layer.circleColor = self.circleColor
        layer.warningThresholdColor = self.warningThresholdColor
        layer.criticalThresholdColor = self.criticalThresholdColor

        layer.thresholdLineLength = self.thresholdLineLength
        layer.thresholdLineWidth = self.thresholdLineWidth
        layer.progressLineWidth = self.progressLineWidth
        layer.circleLineWidth = self.circleLineWidth
        layer.counterClockwise = self.counterClockwise
        layer.progressAnimationDelegate = self

        layer.criticalThreshold = self.criticalThreshold
        layer.warningThreshold = self.warningThreshold
        layer.progress = self.progress
    }
    
    private func compare(threshold: CGFloat, progress: CGFloat) -> Bool {
        
        if invertThresholds {
            return progress <= threshold
        }
        
        return progress >= threshold
    }
    
    private func animateProgressColor(to expectedColor: UIColor) {

        if animationsEnabled && expectedColor != progressLayer.progressColor {
            let animation = CABasicAnimation(keyPath: "colorCorrection")
            animation.fromValue = progressLayer.progressColor.cgColor
            animation.toValue = expectedColor.cgColor
            animation.duration = 0.5
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: self.colorAnimationKey)
        }
        
        self.perceivedProgressColor = expectedColor

    }
    
    private func adjustPerceivedProgressColor() {
        
        guard thresholdColorMatching && (criticalThreshold > 0.0 || warningThreshold > 0.0) else {
            self.animateProgressColor(to: self.progressColor)
            return
        }
        
        var expectedColor = self.progressColor

        var firstThreshold = criticalThreshold
        var firstColor = criticalThresholdColor
        var secondThreshold = warningThreshold
        var secondColor = warningThresholdColor

        if criticalThreshold < warningThreshold && !invertThresholds {
            // backwards setup
            firstThreshold = warningThreshold
            firstColor = warningThresholdColor
            secondThreshold = criticalThreshold
            secondColor = criticalThresholdColor
        }
        
        if compare(threshold: firstThreshold, progress: progress) && firstThreshold > 0.0 {
            expectedColor = firstColor
        } else if compare(threshold: secondThreshold, progress: progress) && secondThreshold > 0.0 {
            expectedColor = secondColor
        }
        
        animateProgressColor(to: expectedColor)
    }
    
    func updateProgressLayer() {
        self.progressLayer.setNeedsDisplay()
    }

    // MARK: Public Methods
    
    /// Cancels the current `progress` update animation, if running
    open func cancelAnimation() {
        guard let presentationLayer = layer.presentation() as? CircleProgressLayer else { return }
        
        let currentValue = presentationLayer.progress
        layer.removeAllAnimations()
        progress = currentValue
        
    }
    
    /// Returns true if the `progress` animation is currently running
    open func isAnimating() -> Bool {
        return layer.animation(forKey: progressAnimationKey) != nil
    }
    
    /// Change the `progress` property to the provided value, and animate the circle from the current value to the provided value.
    /// - parameter value: Value to set the `progress` property.
    open func animateProgress(to value: CGFloat) {
        if isAnimating() {
            cancelAnimation()
        }
        let animation = CABasicAnimation(keyPath: "progress")
        
        let currentProgress = self.progress

        let clicks = CFTimeInterval(Utilities.degrees(radians: abs(currentProgress - value))) * clickDuration
        
        animation.fromValue = self.progress
        animation.toValue = value
        animation.duration = clicks
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        self.progress = value
        progressLayer.add(animation, forKey: progressAnimationKey)
        
    }
    
    /// Updates the title text to the given value, using the `titleFormat` and the `titleProgessMultiplier`
    /// - parameter value: Value, usually matching the `progress` property to set the title text
    open func updateTitle(to value: CGFloat) {
        self.title.text = String(format: self.titleFormat, value * self.titleProgessMultiplier)
        self.title.setNeedsDisplay()
    }
}

// MARK: CAAnimationDelegate implementation
extension PredixCircleProgressView: CAAnimationDelegate {
    
    /// :nodoc:
    open func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        updateTitle(to: self.progress)
    }
}

// MARK: ProgressAnimationDelegate implementation
extension PredixCircleProgressView: ProgressAnimationDelegate {
    
    func progressAnimationUpdated(value: CGFloat) {
        if self.isTitleAnimated {
            self.updateTitle(to: value)
        }
    }
}
