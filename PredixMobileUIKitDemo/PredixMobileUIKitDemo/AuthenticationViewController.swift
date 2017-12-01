//
//  AuthenticationViewController.swift
//  PredixMobileUIKitDemo
//
//  Created by Jeremy Osterhoudt on 10/31/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileUIKit
import PredixSDK

class AuthenticationViewController: UIViewController, PredixAuthenticationViewDelegate {

    @IBOutlet var authenticationView: PredixAuthenticationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var configuration = AuthenticationManagerConfiguration()
        
        //for demo only!  these lines should match your UAA instance url, client id and secret
        configuration.baseURL = URL(string: "https://fa852a1d-23b1-487c-bfa5-10bad040e241.predix-uaa.run.aws-usw02-pr.ice.predix.io")
        configuration.clientId = "nativeClient"
        configuration.clientSecret = "test123"
        
        //for demo only!  Remove these lines if you were to use this in production
        authenticationView.emailTextField.text = "demo"
        authenticationView.passwordTextField.text = "demo"
        
        authenticationView.configuration = configuration
        authenticationView.beginAuthentication()
    }
    
    func authenticationComplete(authenticationView: PredixAuthenticationView, success: Bool, error: Error?) {
        let alert = UIAlertController(title: "Login", message: "Authentication was \(success ? "successful" : "failed")", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
