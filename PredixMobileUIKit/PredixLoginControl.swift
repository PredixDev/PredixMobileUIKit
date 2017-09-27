//
//  PredixLoginControl.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/18/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation
import PredixMobileSDK

//Implemenation TBD
internal class PredixLoginControl {
    public func login() {
        //Placeholder
        let auth = AuthenticationManager(configuration: AuthenticationManagerConfiguration())
        auth.authenticate { (status) in
            print(status)
        }
    }
}
