//
//  Utilities.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 10/11/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation

/// Public helper methods
public enum Utilities {
    
    ///Convert degrees to radians
    public static func radians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(CGFloat.pi) / 180
    }
    
    ///Convert radians to degrees
    public static func degrees(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(CGFloat.pi)
    }
    
    public static func runOnMainThread(closure: @escaping () -> Void) {
        if !Thread.current.isMainThread {
            DispatchQueue.main.async {
                closure()
            }
        } else {
            closure()
        }
    }
}
