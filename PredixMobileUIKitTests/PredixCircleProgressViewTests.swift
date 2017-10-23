//
//  PredixCircleProgressViewTests.swift
//  PredixMobileUIKitTests
//
//  Created by Johns, Andy (GE Corporate) on 10/11/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
@testable import PredixMobileUIKit

class PredixCircleProgressViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitView() {
        let view = PredixCircleProgressView()
        
        XCTAssertTrue(view.layer is CircleProgressLayer, "View layer class was not as expected")
        XCTAssertTrue(view.title != nil, "View Title label was not initialized")
        compareProperties(layer: progressLayer(view), view: view)
        XCTAssertEqual(view, progressLayer(view).progressAnimationDelegate as? PredixCircleProgressView, "Values did not match: progressAnimationDelegate")
    }
    
    func testInitViewWithFrame() {
        let rect = CGRect(x: 0.0, y: 0.0, width: 300, height: 300)
        let view = PredixCircleProgressView(frame: rect)
        
        XCTAssertTrue(view.layer is CircleProgressLayer, "View layer class was not as expected")
        XCTAssertTrue(view.title != nil, "View Title label was not initialized")
        compareProperties(layer: progressLayer(view), view: view)
        XCTAssertEqual(rect, view.layer.bounds, "Layer bounds was not as expected")
        XCTAssertEqual(view, progressLayer(view).progressAnimationDelegate as? PredixCircleProgressView, "Values did not match: progressAnimationDelegate")
    }
    
    func testInitViewWithCoder() {
        
        let expectedView = PredixCircleProgressView()
        let data = NSKeyedArchiver.archivedData(withRootObject: expectedView)
        
        if let view = NSKeyedUnarchiver.unarchiveObject(with: data) as? PredixCircleProgressView {
            compareProperties(layer: progressLayer(view), view: view)
            compareProperties(layer: progressLayer(view), view: expectedView)
            XCTAssertEqual(view, progressLayer(view).progressAnimationDelegate as? PredixCircleProgressView, "Values did not match: progressAnimationDelegate")
        }
    }
    
    func testViewPropertiesArePushedDownToLayer() {
        let view = PredixCircleProgressView()
        assignValues(view: view)
        compareProperties(layer: progressLayer(view), view: view)
    }
    
    func testSetIsTitleHidden() {
        let view = PredixCircleProgressView()
        let value = !view.title.isHidden
        view.isTitleHidden = value
        
        XCTAssertEqual(value, view.title.isHidden, "Values did not match: isTitleHidden")
    }

    func testGetIsTitleHidden() {
        let view = PredixCircleProgressView()
        let value = !view.title.isHidden
        view.title.isHidden = value
        
        XCTAssertEqual(value, view.isTitleHidden, "Values did not match: isTitleHidden")
    }
    
    func testProgressChangeUpdatesTitle() {
        let view = PredixCircleProgressView()

        view.progress = 0.12
        
        XCTAssertEqual("12%", view.title.text, "Title text was not updated")
    }
    
    func testAnimateToProgressCreatesAnimation() {
        let view = PredixCircleProgressView()
        let expectedProgress: CGFloat = 0.99
        view.animateProgress(to: expectedProgress)
        
        if let animation = view.layer.animation(forKey: view.progressAnimationKey) as? CABasicAnimation, let animationToValue = animation.toValue as? CGFloat {
            
            XCTAssertEqual(expectedProgress, animationToValue, accuracy: 0.001, "Updated height not changed as expected")
            
        } else {
            XCTFail("Animation was not created as expected")
        }
    }
    
    func testAnimateToProgressWhileInAnimatingReplacesAnimation() {
        let view = PredixCircleProgressView()
        let notExpectedProgress: CGFloat = 0.99
        let expectedProgress: CGFloat = 0.5
        view.animateProgress(to: notExpectedProgress)
        view.animateProgress(to: expectedProgress)
        
        if let animation = view.layer.animation(forKey: view.progressAnimationKey) as? CABasicAnimation, let animationToValue = animation.toValue as? CGFloat {
            
            XCTAssertEqual(expectedProgress, animationToValue, accuracy: 0.001, "Updated height not changed as expected")
            
        } else {
            XCTFail("Animation was not created as expected")
        }
    }
    
    func testSetThresholdColorMatchingTrueChangesColorToCritical() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true

        view.thresholdColorMatching = false // start as false
        view.criticalThreshold = 0.7 // set threshold
        view.progress = 0.75 // progress above threshold

        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.thresholdColorMatching = true // this should change layer color
        
        validateColorAnimation(view: view, from: view.progressColor, to: view.criticalThresholdColor)
    }
    
    func testSetThresholdColorMatchingTrueChangesColorToWarning() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = false // start as false
        view.criticalThreshold = 0.7 // set threshold
        view.warningThreshold = 0.6 // set threshold
        view.progress = 0.65 // progress above threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.thresholdColorMatching = true // this should change layer color
        
        validateColorAnimation(view: view, from: view.progressColor, to: view.warningThresholdColor)
    }
    
    func testSetProgressWhenThresholdColorMatchingTrueChangesColorToCritical() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.criticalThreshold = 0.7 // set threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.progress = 0.75 // progress above threshold
        
        validateColorAnimation(view: view, from: view.progressColor, to: view.criticalThresholdColor)
    }
    
    func testSetProgressWhenThresholdColorMatchingTrueChangesColorToWarning() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.criticalThreshold = 0.7 // set threshold
        view.warningThreshold = 0.6 // set threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.progress = 0.65 // progress above threshold
        
        validateColorAnimation(view: view, from: view.progressColor, to: view.warningThresholdColor)
    }
    
    func testSetCriticalTholdWhenThresholdColorMatchingTrueChangesColorToCritical() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.progress = 0.75 // progress above threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.criticalThreshold = 0.7 // set threshold

        validateColorAnimation(view: view, from: view.progressColor, to: view.criticalThresholdColor)
    }
    
    func testSetWarningTholdWhenThresholdColorMatchingTrueChangesColorToWarning() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.progress = 0.65 // progress above warning threshold
        view.criticalThreshold = 0.7 // set threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")

        view.warningThreshold = 0.6 // set threshold

        validateColorAnimation(view: view, from: view.progressColor, to: view.warningThresholdColor)
    }
    
    func testSetInvertTholdWhenThresholdColorMatchingTrueChangesColor() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.criticalThreshold = 0.7 // set threshold
        view.progress = 0.65 // progress below threshold
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")
        
        view.invertThresholds = true // invert threshold
        
        validateColorAnimation(view: view, from: view.progressColor, to: view.criticalThresholdColor)
    }

    func testSetInvertTholdWhenThresholdColorMatchingTrueSwapsWarningAndCriticalColors() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.criticalThreshold = 0.7 // set threshold
        view.warningThreshold = 0.6 // set threshold
        view.progress = 0.65 // progress between thresholds
        
        // should be warning color
        validateColorAnimation(view: view, from: view.progressColor, to: view.warningThresholdColor)
        
        view.invertThresholds = true // invert threshold
        
        // after inverting should be going from warning to critical color
        validateColorAnimation(view: view, from: view.warningThresholdColor, to: view.criticalThresholdColor)
    }
    
    func testThresholdColorMatchingTrueCriticalBelowWarning() {
        let view = PredixCircleProgressView()
        view.animationsEnabled = true
        
        view.thresholdColorMatching = true // this should change layer color
        view.criticalThreshold = 0.6 // set threshold
        view.warningThreshold = 0.7 // set threshold
        view.progress = 0.65 // progress between thresholds
        
        // should be critical color
        validateColorAnimation(view: view, from: view.progressColor, to: view.criticalThresholdColor)
    }
    
    func testThresholdColorMatchingFalseDoesNotChangeColor() {
        let view = PredixCircleProgressView()

        view.thresholdColorMatching = false // start as false
        view.criticalThreshold = 0.7 // set threshold
        view.warningThreshold = 0.6 // set threshold
        view.progress = 0.65 // progress above threshold

        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNil(animation, "Animation was set before setting key test value")
    }
    
    func testSetTitleScaleFactorUpdatesConstraints() {
        let view = PredixCircleProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        
        let constraints = titleConstraints(for: view)
        
        if let height = constraints.height, let width = constraints.width {
            
            view.titleScaleFactor = view.titleScaleFactor * 0.5 // cut scale in half
            let updatedConstraints = titleConstraints(for: view)
            if let updatedHeight = updatedConstraints.height, let updatedwidth = updatedConstraints.width {
                
                XCTAssertEqual(height, updatedHeight * 2, accuracy: 0.0001, "Updated height not changed as expected")
                XCTAssertEqual(width, updatedwidth * 2, accuracy: 0.0001, "Updated height not changed as expected")
                
            } else {
                XCTFail("Did not find expected updated title constraints")
            }

        } else {
            XCTFail("Did not find expected title constraints")
        }
    }
    
    func testMoveToWindowUpdatesLayerScale() {
        let win = UIWindow()
        
        let expectedScale = win.screen.scale
        let view = PredixCircleProgressView()
        let layerScale = view.layer.contentsScale
        
        XCTAssertNotEqual(expectedScale, layerScale, accuracy: 0.001, "Scales matched at test start")
        win.addSubview(view)
        
        // ensure scale matches
        XCTAssertEqual(expectedScale, view.layer.contentsScale, accuracy: 0.001, "Scales matched at test start")
    }
    
    func testSetNeedsUpdateConstraintsUpdatesTitleConstraints() {
        let view = PredixCircleProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        
        let initialConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }

        view.setNeedsUpdateConstraints()

        let updatedConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }
        
        XCTAssertNotEqual(initialConstraints, updatedConstraints)
    }

    func testChangeCircleLineWidthUpdatesTitleConstraints() {
        let view = PredixCircleProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        
        let initialConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }
        
        view.circleLineWidth += 10
        
        let updatedConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }
        
        XCTAssertNotEqual(initialConstraints, updatedConstraints)
    }
    
    func testChangeProgressLineWidthUpdatesTitleConstraints() {
        let view = PredixCircleProgressView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        
        let initialConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }
        
        view.progressLineWidth += 10
        
        let updatedConstraints = view.constraints.filter { (constraint) -> Bool in
            return constraint.firstItem === view.title
        }
        
        XCTAssertNotEqual(initialConstraints, updatedConstraints)
    }
    
    func testAwakeFromNibChangesPercievedProgressColorAndEnabledAnimation() {
        let view = PredixCircleProgressView()
        
        view.criticalThreshold = 0.70
        view.warningThreshold = 0.50
        view.progress = 0.6

        if let layer = view.layer as? CircleProgressLayer {
            // set progressColor to different color
            // this simulates property loading in unknown order
            layer.progressColor = UIColor.black
            let initialColor = layer.progressColor
            
            view.awakeFromNib()
            let updatedColor = layer.progressColor
            // validate color was updated, and animation is enabled.
            XCTAssertNotEqual(initialColor, updatedColor, "progress color was not updated")
            XCTAssertEqual(view.warningThresholdColor, updatedColor, "progress color was the expected color")
            XCTAssertTrue(view.animationsEnabled, "Animations were not enabled after awakeFromNib")
        } else {
            XCTFail("Circle layer not expected type")
        }
    }
    
    func testPrepareForInterfaceBuilderChangesPercievedProgressColorAndDoesNotEnableAnimation() {
        let view = PredixCircleProgressView()
        
        view.criticalThreshold = 0.70
        view.warningThreshold = 0.50
        view.progress = 0.6
        
        if let layer = view.layer as? CircleProgressLayer {
            // set progressColor to different color
            // this simulates property loading in unknown order
            layer.progressColor = UIColor.black
            let initialColor = layer.progressColor
            
            view.prepareForInterfaceBuilder()
            let updatedColor = layer.progressColor
            // validate color was updated, and animation is not enabled.
            XCTAssertNotEqual(initialColor, updatedColor, "progress color was not updated")
            XCTAssertEqual(view.warningThresholdColor, updatedColor, "progress color was the expected color")
            XCTAssertFalse(view.animationsEnabled, "Animations were not enabled after awakeFromNib")
        } else {
            XCTFail("Circle layer not expected type")
        }
    }
    
    func titleConstraints(for view: PredixCircleProgressView)->(width: CGFloat?, height: CGFloat?) {
        var height: CGFloat?
        var width: CGFloat?
        for constraint in view.constraints {
            if let label = constraint.firstItem as? UILabel, label == view.title {
                // found constraint for label
                if constraint.firstAttribute == .height {
                    height = constraint.multiplier
                }
                if constraint.firstAttribute == .width {
                    width = constraint.multiplier
                }
            }
        }
        return (height, width)
    }
    
    func validateColorAnimation(view: PredixCircleProgressView, from expectedFromColor: UIColor, to expectedToColor: UIColor) {
        
        let animation = view.layer.animation(forKey: view.colorAnimationKey)
        XCTAssertNotNil(animation, "Animation was not set")
        if let animation = animation as? CABasicAnimation {
            let fromColor = animation.fromValue as! CGColor // swiftlint:disable:this force_cast
            let toColor = animation.toValue as! CGColor // swiftlint:disable:this force_cast
            
            XCTAssertEqual(expectedFromColor.cgColor, fromColor, "Animation from value was not expected color")
            XCTAssertEqual(expectedToColor.cgColor, toColor, "Animation to value was not expected color")
        } else {
            XCTFail("Animation was not expected type")
        }
    }

    func assignValues(view: PredixCircleProgressView) {
        view.thresholdColorMatching = false // set to false so progress color doesn't change.
        view.thresholdLineLength = CGFloat.random
        view.thresholdLineWidth = CGFloat.random
        view.circleColor = UIColor.random
        view.progressColor = UIColor.random
        view.warningThresholdColor = UIColor.random
        view.criticalThresholdColor = UIColor.random
        view.warningThreshold = CGFloat.random
        view.criticalThreshold = CGFloat.random
        view.progressLineWidth = CGFloat.random
        view.circleLineWidth = CGFloat.random
        view.counterClockwise = Bool.random
        view.progress = CGFloat.random
        view.progressAnimationDuration = Double.random
    }
    
    func progressLayer(_ view: PredixCircleProgressView) -> CircleProgressLayer {
        guard let progressLayer = view.layer as? CircleProgressLayer else {
            XCTFail("View layer is not expected type")
            return CircleProgressLayer()
        }
        return progressLayer
    }
    func compareProperties(layer: CircleProgressLayer, view: PredixCircleProgressView) {
        
        XCTAssertEqual(view.progressAnimationDuration / 360.0, layer.clicks, accuracy: 0.001, "Values did not match: clickDuration")
        XCTAssertEqual(view.progressColor, layer.progressColor, "Values did not match: progressColor")
        XCTAssertEqual(view.criticalThreshold, layer.criticalThreshold, accuracy: 0.001, "Values did not match: criticalThreshold")
        XCTAssertEqual(view.criticalThresholdColor, layer.criticalThresholdColor, "Values did not match: criticalThresholdColor")
        XCTAssertEqual(view.circleColor, layer.circleColor, "Values did not match: circleColor")
        XCTAssertEqual(view.progressLineWidth, layer.progressLineWidth, accuracy: 0.001, "Values did not match: progressLineWidth")
        XCTAssertEqual(view.circleLineWidth, layer.circleLineWidth, accuracy: 0.001, "Values did not match: circleLineWidth")
        XCTAssertEqual(view.progress, layer.progress, accuracy: 0.001, "Values did not match: progress")

        XCTAssertEqual(view.thresholdLineLength, layer.thresholdLineLength, accuracy: 0.001, "Values did not match: thresholdLineLength")
        XCTAssertEqual(view.thresholdLineWidth, layer.thresholdLineWidth, accuracy: 0.001, "Values did not match: thresholdLineWidth")
        XCTAssertEqual(view.warningThreshold, layer.warningThreshold, accuracy: 0.001, "Values did not match: warningThreshold")
        XCTAssertEqual(view.warningThresholdColor, layer.warningThresholdColor, "Values did not match: warningThresholdColor")
        XCTAssertEqual(view.counterClockwise, layer.counterClockwise, "Values did not match: counterClockwise")
    }
}
