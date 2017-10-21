//
//  PredixAuthenticationViewTest.swift
//  PredixMobileUIKitTests
//
//  Created by Jeremy Osterhoudt on 10/20/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest

@testable import PredixMobileUIKit
class PredixAuthenticationViewTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testImageSettingTheTitleImageSetsTheImageOnTheImageView() {
        let authenticationView = PredixAuthenticationView()
        let expectedImage = UIImage()
        authenticationView.titleImage = expectedImage
        XCTAssertEqual(expectedImage, authenticationView.titleImageView.image)
    }
    
    func testSettingTheDelegateShouldSetAuthenticationInProgressFalse() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.beginAuthentication()
        authenticationView.delegate = MockDelegate()
        XCTAssertFalse(authenticationView.authenticationInProgress)
    }
    
    func testBeginAuthenticationOnlyRunsOnceIfAuthenticationIsInProgress() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.beginAuthentication()
        let authenticationManager = authenticationView.authenticationManager
        authenticationView.beginAuthentication()
        XCTAssertTrue(authenticationManager === authenticationView.authenticationManager)
    }
    
    func testCallingSignInCallsTheSignInFunctionIfTheDelegateHasItDefined() {
        let authenticationView = PredixAuthenticationView()
        let delegate = MockSignInDelegate()
        authenticationView.delegate = delegate
        authenticationView.signIn(sender: self)
        XCTAssertTrue(delegate.called)
    }

}

private class MockDelegate: NSObject, PredixAuthenticationViewDelegate {
    func authenticationComplete(success: Bool, error: Error?) {
        
    }
}

private class MockSignInDelegate: NSObject, PredixAuthenticationViewDelegate {
    public var called = false
    func signInPressed() {
        called = true
    }
}
