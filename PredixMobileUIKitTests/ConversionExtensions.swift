//
//  ConversionExtensions.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/25/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    internal var asDouble: Double {
        get {
            return Double(self)
        }
    }
}

extension Float {
    internal var asDouble: Double {
        get {
            return Double(self)
        }
    }
}

extension Double {
    internal var asCGFloat: CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
    internal var asFloat: Float {
        get {
            return Float(self)
        }
    }
}
