//
//  RandomExtensions.swift
//  PredixMobileUIKitTests
//
//  Created by Johns, Andy (GE Corporate) on 10/12/17.
//  Copyright © 2017 GE. All rights reserved.
//
// Extensions to provide random values for testing

import Foundation
import UIKit

// MARK: Int Extension

public extension Int {
    
    /// Returns a random Int point number between 0 and UInt32.max.
    public static var random: Int {
        return Int.random(Int(UInt32.max))
    }
    
    /// Random integer between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random Int point number between 0 and n max
    public static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    ///  Random integer between min and max
    ///
    /// - Parameters:
    ///   - min:    Interval minimun
    ///   - max:    Interval max
    /// - Returns:  Returns a random Int point number between 0 and n max
    public static func random(min: Int, max: Int) -> Int {
        return Int.random(max - min + 1) + min
        
    }
}

// MARK: Double Extension

public extension Double {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

// MARK: Float Extension

public extension Float {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random float between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random float point number between 0 and n max
    public static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

// MARK: CGFloat Extension

public extension CGFloat {
    
    /// Randomly returns either 1.0 or -1.0.
    public static var randomSign: CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    /// Random CGFloat between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random CGFloat point number between 0 and n max
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}

public extension Bool {
    public static var random: Bool {
        return Int.random(2) == 0
    }
}
// MARK: UIColor Extension

public extension UIColor {
    public static var random: UIColor {
        // Don't need infinite random colors, just a few will do for testing
        switch Int.random(10) {
        case 0: return UIColor.red
        case 1: return UIColor.orange
        case 2: return UIColor.yellow
        case 3: return UIColor.green
        case 4: return UIColor.blue
        case 5: return UIColor.purple
        case 6: return UIColor.white
        case 7: return UIColor.black
        case 8: return UIColor.clear
        case 9: return UIColor.magenta
        default:  return UIColor.cyan
        }
    }
}
