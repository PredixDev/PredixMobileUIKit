//
//  CircleProgressLayerTests.swift
//  PredixMobileUIKitTests
//
//  Created by Johns, Andy (GE Corporate) on 10/11/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
import UIKit
import CoreGraphics
@testable import PredixMobileUIKit

class CircleProgressLayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitLayer() {
        let layer = CircleProgressLayer()
        XCTAssertNil(layer.progressAnimationDelegate)
        XCTAssertNil(layer.colorCorrection)
    }
    
    func testLayerColorProperties() {
        let layer = CircleProgressLayer()
        let expectedColor = UIColor.random
        layer.circleColor = expectedColor
        XCTAssertEqual(expectedColor, layer.circleColor, "circleColor did not match: circleColor")

        layer.progressColor = expectedColor
        XCTAssertEqual(expectedColor, layer.progressColor, "circleColor did not match: progressColor")

        layer.warningThresholdColor = expectedColor
        XCTAssertEqual(expectedColor, layer.warningThresholdColor, "circleColor did not match: warningThresholdColor")

        layer.criticalThresholdColor = expectedColor
        XCTAssertEqual(expectedColor, layer.criticalThresholdColor, "circleColor did not match: criticalThresholdColor")
    }

    func testLayerCGFloatProperties() {
        let layer = CircleProgressLayer()
        let expectedValue: CGFloat = CGFloat.random
        layer.thresholdLineLength = expectedValue
        XCTAssertEqual(expectedValue, layer.thresholdLineLength, accuracy: 0.001, "Values did not match: thresholdLineLength")

        layer.thresholdLineWidth = expectedValue
        XCTAssertEqual(expectedValue, layer.thresholdLineWidth, accuracy: 0.001, "Values did not match: thresholdLineWidth")

        layer.warningThreshold = expectedValue
        XCTAssertEqual(expectedValue, layer.warningThreshold, accuracy: 0.001, "Values did not match: warningThreshold")

        layer.criticalThreshold = expectedValue
        XCTAssertEqual(expectedValue, layer.criticalThreshold, accuracy: 0.001, "Values did not match: criticalThreshold")

        layer.progressLineWidth = expectedValue
        XCTAssertEqual(expectedValue, layer.progressLineWidth, accuracy: 0.001, "Values did not match: progressLineWidth")

        layer.circleLineWidth = expectedValue
        XCTAssertEqual(expectedValue, layer.circleLineWidth, accuracy: 0.001, "Values did not match: circleLineWidth")
    }
    
    func testLayerOtherProperties() {
        let layer = CircleProgressLayer()
        let expectedValue: CFTimeInterval = CFTimeInterval(CGFloat.random)
        layer.clicks = expectedValue
        XCTAssertEqual(expectedValue, layer.clicks, accuracy: 0.001, "Values did not match: clicks")

        let expectedBool = !layer.counterClockwise
        layer.counterClockwise = expectedBool
        XCTAssertEqual(expectedBool, layer.counterClockwise, "Values did not match: counterClockwise")
    }
    
    func testInitWithLayer() {
        let expectedLayer = CircleProgressLayer()
        
        expectedLayer.progressAnimationDelegate = TestAnimationDelegate()
        expectedLayer.thresholdLineLength = CGFloat.random
        expectedLayer.thresholdLineWidth = CGFloat.random
        expectedLayer.circleColor = UIColor.random
        expectedLayer.progressColor = UIColor.random
        expectedLayer.warningThresholdColor = UIColor.random
        expectedLayer.criticalThresholdColor = UIColor.random
        expectedLayer.warningThreshold = CGFloat.random
        expectedLayer.criticalThreshold = CGFloat.random
        expectedLayer.clicks = CFTimeInterval(CGFloat.random)
        expectedLayer.progressLineWidth = CGFloat.random
        expectedLayer.circleLineWidth = CGFloat.random
        expectedLayer.counterClockwise = Bool.random
        expectedLayer.progress = CGFloat.random
        expectedLayer.colorCorrection = UIColor.random
        
        let layer = CircleProgressLayer(layer: expectedLayer)
        
        XCTAssertEqual(expectedLayer.progressAnimationDelegate as? TestAnimationDelegate, layer.progressAnimationDelegate as? TestAnimationDelegate, "Values did not match: progressAnimationDelegate")
        XCTAssertEqual(expectedLayer.thresholdLineLength, layer.thresholdLineLength, "Values did not match: thresholdLineLength")
        XCTAssertEqual(expectedLayer.thresholdLineWidth, layer.thresholdLineWidth, "Values did not match: thresholdLineWidth")
        XCTAssertEqual(expectedLayer.circleColor, layer.circleColor, "Values did not match: circleColor")
        XCTAssertEqual(expectedLayer.progressColor, layer.progressColor, "Values did not match: progressColor")
        XCTAssertEqual(expectedLayer.warningThresholdColor, layer.warningThresholdColor, "Values did not match: warningThresholdColor")
        XCTAssertEqual(expectedLayer.criticalThresholdColor, layer.criticalThresholdColor, "Values did not match: criticalThresholdColor")
        XCTAssertEqual(expectedLayer.warningThreshold, layer.warningThreshold, "Values did not match: warningThreshold")
        XCTAssertEqual(expectedLayer.criticalThreshold, layer.criticalThreshold, "Values did not match: criticalThreshold")
        XCTAssertEqual(expectedLayer.clicks, layer.clicks, "Values did not match: clicks")
        XCTAssertEqual(expectedLayer.progressLineWidth, layer.progressLineWidth, "Values did not match: progressLineWidth")
        XCTAssertEqual(expectedLayer.circleLineWidth, layer.circleLineWidth, "Values did not match: circleLineWidth")
        XCTAssertEqual(expectedLayer.counterClockwise, layer.counterClockwise, "Values did not match: counterClockwise")
        XCTAssertEqual(expectedLayer.progress, layer.progress, "Values did not match: progress")
        XCTAssertEqual(expectedLayer.colorCorrection, layer.colorCorrection, "Values did not match: colorCorrection")
    }
    
    func testInitWithCoder() {
        
        let expectedLayer = CircleProgressLayer()
        
        expectedLayer.progressAnimationDelegate = TestAnimationDelegate()
        expectedLayer.thresholdLineLength = CGFloat.random
        expectedLayer.thresholdLineWidth = CGFloat.random
        expectedLayer.circleColor = UIColor.random
        expectedLayer.progressColor = UIColor.random
        expectedLayer.warningThresholdColor = UIColor.random
        expectedLayer.criticalThresholdColor = UIColor.random
        expectedLayer.warningThreshold = CGFloat.random
        expectedLayer.criticalThreshold = CGFloat.random
        expectedLayer.clicks = CFTimeInterval(CGFloat.random)
        expectedLayer.progressLineWidth = CGFloat.random
        expectedLayer.circleLineWidth = CGFloat.random
        expectedLayer.counterClockwise = Bool.random
        expectedLayer.progress = CGFloat.random
        expectedLayer.colorCorrection = UIColor.random
        
        let data = NSKeyedArchiver.archivedData(withRootObject: expectedLayer)
        
        if let layer = NSKeyedUnarchiver.unarchiveObject(with: data) as? CircleProgressLayer {
            
            XCTAssertEqual(expectedLayer.progressAnimationDelegate as? TestAnimationDelegate, layer.progressAnimationDelegate as? TestAnimationDelegate, "Values did not match: progressAnimationDelegate")
            XCTAssertEqual(expectedLayer.thresholdLineLength, layer.thresholdLineLength, "Values did not match: thresholdLineLength")
            XCTAssertEqual(expectedLayer.thresholdLineWidth, layer.thresholdLineWidth, "Values did not match: thresholdLineWidth")
            XCTAssertEqual(expectedLayer.circleColor, layer.circleColor, "Values did not match: circleColor")
            XCTAssertEqual(expectedLayer.progressColor, layer.progressColor, "Values did not match: progressColor")
            XCTAssertEqual(expectedLayer.warningThresholdColor, layer.warningThresholdColor, "Values did not match: warningThresholdColor")
            XCTAssertEqual(expectedLayer.criticalThresholdColor, layer.criticalThresholdColor, "Values did not match: criticalThresholdColor")
            XCTAssertEqual(expectedLayer.warningThreshold, layer.warningThreshold, "Values did not match: warningThreshold")
            XCTAssertEqual(expectedLayer.criticalThreshold, layer.criticalThreshold, "Values did not match: criticalThreshold")
            XCTAssertEqual(expectedLayer.clicks, layer.clicks, "Values did not match: clicks")
            XCTAssertEqual(expectedLayer.progressLineWidth, layer.progressLineWidth, "Values did not match: progressLineWidth")
            XCTAssertEqual(expectedLayer.circleLineWidth, layer.circleLineWidth, "Values did not match: circleLineWidth")
            XCTAssertEqual(expectedLayer.counterClockwise, layer.counterClockwise, "Values did not match: counterClockwise")
            XCTAssertEqual(expectedLayer.progress, layer.progress, "Values did not match: progress")
            XCTAssertEqual(expectedLayer.colorCorrection, layer.colorCorrection, "Values did not match: colorCorrection")
        } else {
            XCTFail("Init did not return layer")
        }
    }
    
    func testInitWithCoderReturnsNil() {
        let testObj = "Hello World"
        let data = NSKeyedArchiver.archivedData(withRootObject: testObj)
        let decoder = NSKeyedUnarchiver(forReadingWith: data)
        
        let notALayer = CircleProgressLayer(coder: decoder)
        XCTAssertNil(notALayer, "Init returned a layer unexpectedly")
        
    }
    
    func testDraw() {
        // Doesn't check that the image is correct, just validates that something was drawn.
        
        let layer = CircleProgressLayer()
        layer.warningThreshold = 0.70
        layer.criticalThreshold = 0.80
        layer.progress = 0.65
        
        let image = createImage(from: layer)

        var foundNonZeroBytes = false
        if let dataProvider = image.cgImage?.dataProvider {
            let data: Data = dataProvider.data.unsafelyUnwrapped as Data
            let array = [UInt8](data)
            for ndx in 0...array.count - 1 {
                if array[ndx] != 0 {
                    foundNonZeroBytes = true
                    break
                }
            }
        }
        
        XCTAssertTrue(foundNonZeroBytes, "Drawn image contained no data")
    }

    
    
    func testDrawCounterClockwise() {

        let clockwiseLayer = CircleProgressLayer()
        clockwiseLayer.warningThreshold = 0.70
        clockwiseLayer.criticalThreshold = 0.80
        clockwiseLayer.progress = 0.65
        
        let clockwiseImage = createImage(from: clockwiseLayer)
        
        let counterClockLayer = CircleProgressLayer(layer: clockwiseLayer)
        counterClockLayer.counterClockwise = true
        let counterClockImage = createImage(from: counterClockLayer)
        
        if let dataProvider = clockwiseImage.cgImage?.dataProvider, let dataProvider2 = counterClockImage.cgImage?.dataProvider {
            let clockwiseData: Data = dataProvider.data.unsafelyUnwrapped as Data
            let counterClockData: Data = dataProvider2.data.unsafelyUnwrapped as Data
            let clockwiseArray = [UInt8](clockwiseData)
            let counterClockArray = [UInt8](counterClockData)
            
            XCTAssertFalse(clockwiseArray.elementsEqual(counterClockArray), "Byte arrays are the same")
        } else {
            XCTFail("Drawn image contained no data")
        }
    }
    
    func testAnimationDelegateCalled() {
        
        let expectedValue: CGFloat = 0.65
        let delegate = TestAnimationDelegate()
        delegate.expectation = self.expectation(description: #function)
        delegate.expectedProgressValue = expectedValue
        let layer = CircleProgressLayer()
        layer.progressAnimationDelegate = delegate
        layer.progress = expectedValue
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    
    func createImage(from layer: CALayer)->UIImage {
        let bounds = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
        layer.bounds = bounds
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { context in
            layer.draw(in: context.cgContext)
        }
        return image
    }

    class TestAnimationDelegate: ProgressAnimationDelegate, Equatable {
        static func ==(lhs: CircleProgressLayerTests.TestAnimationDelegate, rhs: CircleProgressLayerTests.TestAnimationDelegate) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id: UUID
        var expectation: XCTestExpectation?
        var expectedProgressValue: CGFloat?
        
        init() {
            self.id = UUID()
        }
        
        func progressAnimationUpdated(value: CGFloat) {
            if let expectedProgressValue = self.expectedProgressValue {
                XCTAssertEqual(expectedProgressValue, value, accuracy: 0.001, "Animation update value was not as expected")
            } else {
                XCTFail("Delegate expectedProgressValue was not set for test")
            }
            expectation?.fulfill()
        }
        
        
    }

}


