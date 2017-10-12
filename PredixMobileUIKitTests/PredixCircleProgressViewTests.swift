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

    func assignValues(view: PredixCircleProgressView) {
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
    
    func progressLayer(_ view: PredixCircleProgressView)->CircleProgressLayer {
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
