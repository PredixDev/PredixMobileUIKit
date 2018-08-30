//
//  PredixAuthenticationViewTest.swift
//  PredixMobileUIKitTests
//
//  Created by Jeremy Osterhoudt on 10/20/17.
//  Copyright © 2017 GE. All rights reserved.
//

import XCTest
import PredixSDK
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
        XCTAssertEqual(authenticationView, delegate.authenticationView)
    }
    
    func testInitWithCoder() {
        let authenticationView = PredixAuthenticationView()
        let data = NSMutableData()
        let coder = NSKeyedArchiver(forWritingWith: data)
        coder.encode(authenticationView)
        coder.finishEncoding()
        
        let decoder = NSKeyedUnarchiver(forReadingWith: data as Data)
        let newAuthenticationView = PredixAuthenticationView(coder: decoder)
        XCTAssertNotNil(newAuthenticationView)
    }
    
    func testLayoutSubViews() {
        let view = PredixAuthenticationView(frame: CGRect())
        view.bounds = CGRect(x: 5, y: 1, width: 44, height: 1044)
        view.layoutSubviews()
        
        XCTAssertEqual(view.bounds, view.scrollView.frame)
    }
    
    func testSignInShouldShowActivitySpinner() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.signIn(sender: self)
        
        XCTAssertTrue(authenticationView.activityIndicator.isAnimating)
    }
    
    func testTheSpinnerIsHiddenWhenAuthenticationCompletes() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.signIn(sender: self)
        
        authenticationView.authenticationHandlerProvidedCredentialsWereInvalid(UAARefreshAuthenticationHandler())
        XCTAssertFalse(authenticationView.activityIndicator.isAnimating)
    }
    
    func testTheSpinnerIsHiddenWhenAuthenticationCompletesWithAnError() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.signIn(sender: self)
        let error = NSError(domain: PredixSDKErrorDomain.authentication.description, code: 999, userInfo: [NSLocalizedDescriptionKey: "credentials were invalid"])
        authenticationView.authenticationHandler(UAARefreshAuthenticationHandler(), didFailWithError: error)
        
        XCTAssertFalse(authenticationView.activityIndicator.isAnimating)
    }
    
    func testTheSpinnerShouldShowWhenATokenIsRefreshed() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.authenticationManager = AuthenticationManager(configuration: AuthenticationManagerConfiguration())
        authenticationView.authenticationManager?.onlineAuthenticationHandler = UAAServiceAuthenticationHandler()
        let refreshHandler = AuthenticationViewRefreshHandler(authenticationView: authenticationView)
        authenticationView.authenticationManager?.onlineAuthenticationHandler?.refreshAuthenticationHandler = refreshHandler
        authenticationView.authenticationManager?.onlineAuthenticationHandler?.refreshAuthenticationHandler?.performRefresh(token: "")
        
        XCTAssertTrue(authenticationView.activityIndicator.isAnimating)
    }
    
    func testTextFildShouldBeginEditingSetsTheActiveTextField() {
        let authenticationView = PredixAuthenticationView()
        let textField = UITextField()
        
        XCTAssertTrue(authenticationView.textFieldShouldBeginEditing(textField))
        XCTAssertEqual(textField, authenticationView.activeTextField)
    }
    
    func testThePasswordTextFieldIsSetActiveWhenTextFieldShouldReturnIsCalled() {
        let authenticationView = PredixAuthenticationView()
        
        XCTAssertTrue(authenticationView.textFieldShouldReturn(authenticationView.emailTextField))
    }
    
    func testSingInShouldBeCalledWhenTextFieldShouldReturnIsCalledWithoutTheEmailField() {
        let authenticationView = PredixAuthenticationView()
        
        XCTAssertTrue(authenticationView.textFieldShouldReturn(UITextField()))
    }
    
    func testCallingBeginAuthenticationShouldSetAuthenticationInProgress() {
        let authenticationView = PredixAuthenticationView()
        
        authenticationView.beginAuthentication()
        
        XCTAssertTrue(authenticationView.authenticationInProgress)
    }
    
    func testCallingBeginAuthenticationShouldUseTheSetOnlineHandler() {
        let onlineHandler = UAAServiceAuthenticationHandler()
        let authenticationView = PredixAuthenticationView()
        authenticationView.onlineHandler = onlineHandler
        
        authenticationView.beginAuthentication()
        
        XCTAssertTrue(onlineHandler === authenticationView.authenticationManager?.onlineAuthenticationHandler)
    }
    
    func testSuccessfulAuthenticationHidesTheSpinner() {
        let delegate = MockDelegate()
        let authenticationView = PredixAuthenticationView()
        authenticationView.authenticationManager = AuthenticationManager(configuration: AuthenticationManagerConfiguration())
        authenticationView.delegate = delegate
        
        authenticationView.beginAuthentication()
        
        XCTAssertFalse(authenticationView.activityIndicator.isAnimating)
    }
    
    func testCredentialsAreProvidedWhenSignInIsPressed() {
        let authenticationView = PredixAuthenticationView()
        let onlineHandler = MockOnlineHandler()
        authenticationView.onlineHandler = onlineHandler
        authenticationView.emailTextField.text = "me"
        authenticationView.passwordTextField.text = "god"
        authenticationView.beginAuthentication()
        authenticationView.onlineHandler?.authenticationServiceDelegate = authenticationView
        authenticationView.onlineHandler?.performOnlineAuthentication()
        
        authenticationView.signIn(sender: self)
        
        XCTAssertEqual("me", onlineHandler.setUsername)
        XCTAssertEqual("god", onlineHandler.setPassword)
    }
    
    func testNothingHappensIfNoProviderIsSetOnSignIn() {
        let authenticationView = PredixAuthenticationView()
        let onlineHandler = MockOnlineHandler()
        authenticationView.onlineHandler = onlineHandler
        authenticationView.emailTextField.text = nil
        authenticationView.passwordTextField.text = nil
        authenticationView.onlineHandler?.authenticationServiceDelegate = authenticationView
        
        authenticationView.signIn(sender: self)
    }
    
    func testTheScrollViewContentOffsetIsSetIfTheKeyboardBlocksTheTextField() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.scrollView.contentSize = CGSize(width: 100, height: 200)
        authenticationView.emailTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let kbNotification = NSNotification(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 100, height: 100) as NSValue])
        
        _ = authenticationView.textFieldShouldBeginEditing(authenticationView.emailTextField)
        authenticationView.keyboardWillShow(notification: kbNotification)
        
        XCTAssertEqual(100.0, authenticationView.scrollView.contentOffset.y)
    }
    
    func testKeyboardWillHideNotificationResetsTheContentSize() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.scrollView.contentSize = CGSize(width: 100, height: 200)
        authenticationView.emailTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let kbNotification = NSNotification(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 100, height: 100) as NSValue])
        
        _ = authenticationView.textFieldShouldBeginEditing(authenticationView.emailTextField)
        authenticationView.keyboardWillShow(notification: kbNotification)
        authenticationView.keyboardWillHide(notification: kbNotification)
        
        XCTAssertEqual(CGSize(), authenticationView.scrollView.contentSize)
        XCTAssertEqual(CGPoint(), authenticationView.scrollView.contentOffset)
    }
    
    func testHideKeyboardResetsTheContentSize() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.scrollView.contentSize = CGSize(width: 100, height: 200)
        authenticationView.emailTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let kbNotification = NSNotification(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 100, height: 100) as NSValue])
        
        _ = authenticationView.textFieldShouldBeginEditing(authenticationView.emailTextField)
        authenticationView.keyboardWillShow(notification: kbNotification)
        authenticationView.hideKeyboard()
        
        XCTAssertEqual(CGSize(), authenticationView.scrollView.contentSize)
        XCTAssertEqual(CGPoint(), authenticationView.scrollView.contentOffset)
    }
    
    func testHideKeyboardResetsRemovesTheFirstResponder() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.scrollView.contentSize = CGSize(width: 100, height: 200)
        authenticationView.emailTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let kbNotification = NSNotification(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 100, height: 100) as NSValue])
        
        _ = authenticationView.textFieldShouldBeginEditing(authenticationView.emailTextField)
        authenticationView.keyboardWillShow(notification: kbNotification)
        authenticationView.hideKeyboard()
        
        XCTAssertFalse(authenticationView.activeTextField?.isFirstResponder ?? false)
    }
    
    func testAuthenticationCompleteHidesTheSpinner() {
        let authenticationView = PredixAuthenticationView()
        authenticationView.signIn(sender: self)
        
        authenticationView.authenticationComplete(status: AuthenticationManager.AuthenticationCompletionStatus.denied)
        
        XCTAssertFalse(authenticationView.activityIndicator.isAnimating)
        XCTAssertTrue(authenticationView.isUserInteractionEnabled)
    }
}

private class MockOnlineHandler: UAAServiceAuthenticationHandler {
    var setUsername: String?
    var setPassword: String?
    
    override open func performOnlineAuthentication() {
        self.authenticationServiceDelegate?.authenticationHandler(self, provideCredentialsWithCompletionHandler: self.receiveCredentials)
    }
    
    override open func createAuthenticationRequestPayload(userName: String, password: String) -> [String: String] {
        self.setUsername = userName
        self.setPassword = password
        return [:]
    }
    
    fileprivate func receiveCredentials(_ userName: String, _ password: String) {
        self.performAuthenticationRequest(userName: userName, password: password)
    }
}

private class MockDelegate: NSObject, PredixAuthenticationViewDelegate {
    var lastSuccessValue: Bool?
    var lastError: Error?
    var authenticationView: PredixAuthenticationView?
    
    func authenticationComplete(authenticationView: PredixAuthenticationView, success: Bool, error: Error?) {
        self.lastSuccessValue = success
        self.lastError = error
        self.authenticationView = authenticationView
    }
}

private class MockSignInDelegate: NSObject, PredixAuthenticationViewDelegate {
    var called = false
    var authenticationView: PredixAuthenticationView?
    
    func overrideAuthentication(authenticationView: PredixAuthenticationView) {
        self.authenticationView = authenticationView
        called = true
    }
}
