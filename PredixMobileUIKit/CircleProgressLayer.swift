//
//  CircleProgressLayer.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 10/6/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

internal protocol ProgressAnimationDelegate: class {
    func progressAnimationUpdated(value: CGFloat)
}

internal class CircleProgressLayer: CALayer {
    
    // MARK: Private constants
    private let startAngle = 3 * CGFloat.pi / 2
    private let completeCircle = CGFloat.pi * 2
    private let paddingSpaceFactor: CGFloat = 0.95
    
    // MARK: Internal properties
    internal weak var progressAnimationDelegate: ProgressAnimationDelegate?
    internal var thresholdLineLength: CGFloat = 20
    internal var thresholdLineWidth: CGFloat = 1.0
    internal var circleColor = UIColor.gray
    internal var progressColor = UIColor.green
    internal var warningThresholdColor = UIColor.orange
    internal var criticalThresholdColor = UIColor.red
    internal var warningThreshold: CGFloat = 0.0
    internal var criticalThreshold: CGFloat = 0.0
    internal var clicks: CFTimeInterval = 1.5/360
    internal var progressLineWidth: CGFloat = 10.0
    internal var circleLineWidth: CGFloat = 10.0
    internal var counterClockwise: Bool = false
    
    // MARK: Private properties
    private var center: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private var radius: CGFloat {
        return (bounds.midX - (progressLineWidth * 0.5)) * paddingSpaceFactor
    }
    
    // MARK: Animation properties
    @objc internal var progress: CGFloat = 0.0 {
        didSet {
            if let progressAnimationDelegate = self.progressAnimationDelegate {
                progressAnimationDelegate.progressAnimationUpdated(value: progress)
            }
        }
    }
    
    @objc internal var colorCorrection: CGColor?
    
    // MARK: CALayer overrides
    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "progress" : return true
        case "colorCorrection": return true
        default: return super.needsDisplay(forKey: key)
        }
    }
    
    override func draw(in ctx: CGContext) {
        
        UIGraphicsPushContext(ctx)
        
        drawIncomplete(ctx)
        
        drawProgress(ctx)
        
        // draw threshold lines if needed
        if thresholdLineLength > 0.0 {
            if warningThreshold > 0.0 {
                draw(threshold: CGFloat(warningThreshold), context: ctx, color: warningThresholdColor, center: center, radius: radius)
            }
            if criticalThreshold > 0.0 {
                draw(threshold: CGFloat(criticalThreshold), context: ctx, color: criticalThresholdColor, center: center, radius: radius)
            }
        }
        
        UIGraphicsPopContext()
    }
    
    // MARK: Initialization
    override init(layer: Any) {
        if let layer = layer as? CircleProgressLayer {
            self.clicks = layer.clicks
            self.progressColor = layer.progressColor
            self.colorCorrection = layer.colorCorrection
            self.criticalThreshold = layer.criticalThreshold
            self.criticalThresholdColor = layer.criticalThresholdColor
            self.circleColor = layer.circleColor
            self.progressLineWidth = layer.progressLineWidth
            self.circleLineWidth = layer.circleLineWidth
            self.progress = layer.progress
            self.progressAnimationDelegate = layer.progressAnimationDelegate
            self.thresholdLineLength = layer.thresholdLineLength
            self.thresholdLineWidth = layer.thresholdLineWidth
            self.warningThreshold = layer.warningThreshold
            self.warningThresholdColor = layer.warningThresholdColor
            self.counterClockwise = layer.counterClockwise
        }
        super.init(layer: layer)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let progressColor =  aDecoder.decodeObject(forKey: "progressColor") as? UIColor,
            let criticalThresholdColor =  aDecoder.decodeObject(forKey: "criticalThresholdColor") as? UIColor,
            let circleColor =  aDecoder.decodeObject(forKey: "circleColor") as? UIColor,
            let warningThresholdColor =  aDecoder.decodeObject(forKey: "warningThresholdColor") as? UIColor else {
                
                return nil
        }
        
        self.clicks =  aDecoder.decodeDouble(forKey: "clicks")
        self.criticalThreshold =  CGFloat(aDecoder.decodeDouble(forKey: "criticalThreshold"))
        self.progressLineWidth =  CGFloat(aDecoder.decodeDouble(forKey: "progressLineWidth"))
        self.circleLineWidth =  CGFloat(aDecoder.decodeDouble(forKey: "circleLineWidth"))
        self.progress =  CGFloat(aDecoder.decodeDouble(forKey: "progress"))
        self.thresholdLineLength =  CGFloat(aDecoder.decodeDouble(forKey: "thresholdLineLength"))
        self.thresholdLineWidth =  CGFloat(aDecoder.decodeDouble(forKey: "thresholdLineWidth"))
        self.warningThreshold =  CGFloat(aDecoder.decodeDouble(forKey: "warningThreshold"))
        self.counterClockwise =  aDecoder.decodeBool(forKey: "counterClockwise")
        self.progressColor = progressColor
        self.criticalThresholdColor = criticalThresholdColor
        self.circleColor = circleColor
        self.warningThresholdColor = warningThresholdColor
        if aDecoder.containsValue(forKey: "colorCorrection") {
            self.colorCorrection = (aDecoder.decodeObject(forKey: "colorCorrection") as? UIColor)?.cgColor
        }
        
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(clicks, forKey: "clicks")
        aCoder.encode(progressColor, forKey: "progressColor")
        if let colorCorrection = colorCorrection {
            aCoder.encode(UIColor(cgColor: colorCorrection), forKey: "colorCorrection")
        }
        aCoder.encode(Double(criticalThreshold), forKey: "criticalThreshold")
        aCoder.encode(criticalThresholdColor, forKey: "criticalThresholdColor")
        aCoder.encode(circleColor, forKey: "circleColor")
        aCoder.encode(Double(progressLineWidth), forKey: "progressLineWidth")
        aCoder.encode(Double(circleLineWidth), forKey: "circleLineWidth")
        aCoder.encode(Double(progress), forKey: "progress")
        aCoder.encode(Double(thresholdLineLength), forKey: "thresholdLineLength")
        aCoder.encode(Double(thresholdLineWidth), forKey: "thresholdLineWidth")
        aCoder.encode(Double(warningThreshold), forKey: "warningThreshold")
        aCoder.encode(warningThresholdColor, forKey: "warningThresholdColor")
        aCoder.encode(counterClockwise, forKey: "counterClockwise")
        super.encode(with: aCoder)
    }
    
    // MARK: Private methods
    
    private func drawIncomplete(_ ctx: CGContext) {
        ctx.setStrokeColor(circleColor.cgColor)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.setLineWidth(circleLineWidth)
        ctx.setLineCap(.butt)
        
        ctx.addArc(center: self.center, radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)
        ctx.drawPath(using: .fillStroke)
    }
    
    private func drawProgress(_ ctx: CGContext) {
        
        var progressColor = self.progressColor.cgColor
        if let colorCorrection = colorCorrection {
            progressColor = colorCorrection
        }
        
        let endAngle: CGFloat = self.calculateAngle(percent: self.progress)
        
        ctx.move(to: self.pointOnCircle(angle: startAngle, radius: self.radius, center: self.center))
        ctx.setStrokeColor(progressColor)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.setLineWidth(self.progressLineWidth)
        ctx.setLineCap(.butt)
        
        ctx.addArc(center: self.center, radius: self.radius, startAngle: self.startAngle, endAngle: endAngle, clockwise: self.counterClockwise)
        ctx.drawPath(using: .stroke)
    }
    
    private func calculateAngle(percent: CGFloat) -> CGFloat {
        
        var angle: CGFloat = completeCircle * CGFloat(percent)
        
        if self.counterClockwise {
            angle = self.startAngle - angle
        } else {
            angle += self.startAngle
        }
        
        return angle
    }
    
    private func draw(threshold: CGFloat, context: CGContext, color: UIColor, center: CGPoint, radius: CGFloat) {
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(thresholdLineWidth)
        context.setLineCap(.square)
        
        let angle: CGFloat = self.calculateAngle(percent: threshold)
        let thresholdOverlap = thresholdLineLength / 2.0
        
        let point1 = self.pointOnCircle(angle: angle, radius: radius + thresholdOverlap, center: center)
        let point2 = self.pointOnCircle(angle: angle, radius: radius - thresholdOverlap, center: center)
        
        context.move(to: point1)
        context.addLine(to: point2)
        context.drawPath(using: .stroke)
    }
    
    private func pointOnCircle(angle: CGFloat, radius: CGFloat, center: CGPoint) -> CGPoint {
        
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
}
