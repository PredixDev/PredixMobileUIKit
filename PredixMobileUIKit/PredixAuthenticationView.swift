//
//  PredixAuthenticationView.swift
//  PredixMobileUIKit
//
//  Created by Jeremy Osterhoudt on 10/17/17.
//  Copyright © 2017 GE. All rights reserved.
//

import UIKit
import PredixMobileSDK
import QuartzCore

@IBDesignable
open class PredixAuthenticationView: UIView {
    private var scrollView: UIScrollView = UIScrollView()
    private var footerLabel: UILabel = UILabel()
    private var activeTextField: UITextField?
    private var keyboardRect: CGRect?
    private var firstSet = true
    internal private(set) var authenticationManager: AuthenticationManager?
    private var credentialProvider: AuthenticationCredentialsProvider?
    public private(set) var authenticationInProgress = false
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    open let titleImageView: UIImageView = UIImageView()
    open let emailTextField: UITextField = UITextField()
    open let passwordTextField: UITextField = UITextField()
    open let signInButton: UIButton = UIButton(type: .system)
    
    open var configuration: AuthenticationManagerConfiguration = AuthenticationManagerConfiguration()
    open var onelineHandler: ServiceBasedAuthenticationHandler? {
        didSet {
            authenticationManager?.onlineAuthenticationHandler = onelineHandler
        }
    }
    
    @IBInspectable
    open var titleImage: UIImage? = UIImage(named: "predixTitle.png", in: Bundle(for: PredixAuthenticationView.self), compatibleWith: nil) {
        didSet {
            titleImageView.image = titleImage
        }
    }
    
    @IBInspectable
    open override var backgroundColor: UIColor? {
        didSet {
            //Temporary work around to get past an IB limitation where you can't set a default background color and have it changeable in IB at the same time
            if firstSet {
                firstSet = false
                backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            }
        }
    }
    
    @IBInspectable @IBOutlet
    public weak var delegate: PredixAuthenticationViewDelegate? {
        didSet {
            authenticationInProgress = false
        }
    }
    
    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialization()
    }
    
    /// :nodoc:
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    private func initialization() {
        //A basic rectangle starting point.  The size doesn't matter because autolayout will adjust the frame for us once we set our bounds in layoutSubviews
        let baseRect = CGRect(x: 0, y: 0, width: 320, height: 480)
        let baseInsetX: CGFloat = 16.0
        let top: CGFloat = 30.0
        let width = baseRect.size.width - floor(baseInsetX * 2)
        let fieldHeight: CGFloat = 44.0
        let fieldSpacing: CGFloat = 70.0
        let fieldResizeMask:UIViewAutoresizing = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        setupScrollView(with: baseRect)
        setupTitleImage(with: CGRect(x: baseInsetX, y: top, width: width, height: 56), autoresizingMask: fieldResizeMask)
        setupEmailTextField(with: CGRect(x: baseInsetX, y: top + fieldSpacing, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupPasswordTextField(with: CGRect(x: baseInsetX, y: top + fieldSpacing * 2, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupSignInButton(with: CGRect(x: baseInsetX, y: top + fieldSpacing * 3, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupFooter(with: CGRect(x: 4, y: baseRect.size.height - 30, width: baseRect.size.width - 8, height: 24))

        addSubview(scrollView)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
    }
    
    fileprivate func showActivitySpinner() {
        self.activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        self.signInButton.setTitle("", for: .normal)
    }
    
    fileprivate func hideActivitySpinner() {
        self.activityIndicator.stopAnimating()
        self.isUserInteractionEnabled = true
        self.signInButton.setTitle("Sign In", for: .normal)
    }
    
    private func setupScrollView(with rect: CGRect) {
        scrollView.frame = rect
        scrollView.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth, .flexibleHeight]
        
        NotificationCenter.default.addObserver(self, selector: #selector(PredixAuthenticationView.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PredixAuthenticationView.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PredixAuthenticationView.hideKeyboard))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(tapGesture)
        
        scrollView.addSubview(titleImageView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(signInButton)
        scrollView.addSubview(footerLabel)
    }
    
    private func setupTitleImage(with rect: CGRect, autoresizingMask: UIViewAutoresizing) {
        titleImageView.image = titleImage
        titleImageView.frame = rect
        titleImageView.autoresizingMask = autoresizingMask
        titleImageView.contentMode = .scaleAspectFit
    }
    
    private func setupEmailTextField(with rect: CGRect, autoresizingMask: UIViewAutoresizing) {
        emailTextField.frame = rect
        emailTextField.autoresizingMask = autoresizingMask
        emailTextField.borderStyle = .bezel
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = UITextContentType.emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.enablesReturnKeyAutomatically = true
        emailTextField.clearButtonMode = .whileEditing
    }
    
    private func setupPasswordTextField(with rect: CGRect, autoresizingMask: UIViewAutoresizing) {
        passwordTextField.frame = rect
        passwordTextField.autoresizingMask = autoresizingMask
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .bezel
        passwordTextField.backgroundColor = .white
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .go
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.enablesReturnKeyAutomatically = true
    }
    
    private func setupSignInButton(with rect: CGRect, autoresizingMask: UIViewAutoresizing) {
        signInButton.frame = rect
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = UIColor(red: 39.0/255.0, green: 87.0/255.0, blue: 145.0/255.0, alpha: 1.0)
        signInButton.layer.contentsScale = self.window?.screen.scale ?? layer.contentsScale
        signInButton.layer.cornerRadius = rect.size.height / 6
        signInButton.layer.masksToBounds = true
        signInButton.autoresizingMask = autoresizingMask
        signInButton.addTarget(self, action: #selector(PredixAuthenticationView.signIn(sender:)), for: .touchUpInside)
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.isExclusiveTouch = false
        signInButton.addSubview(activityIndicator)
    }
    
    private func setupFooter(with rect: CGRect) {
        footerLabel.frame = rect
        footerLabel.text = "Copyright © 2017 General Electric Company. All rights reserved."
        footerLabel.textColor = .white
        footerLabel.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        footerLabel.minimumScaleFactor = 0.5
        footerLabel.baselineAdjustment = .alignCenters
        footerLabel.lineBreakMode = .byWordWrapping
        footerLabel.adjustsFontSizeToFitWidth = true
        footerLabel.textAlignment = .center
        footerLabel.allowsDefaultTighteningForTruncation = true
        footerLabel.font = UIFont.systemFont(ofSize: 10)
    }
}

private class AuthenticationViewRefreshHandler: UAARefreshAuthenticationHandler {
    private weak var authenticationView: PredixAuthenticationView?
    
    fileprivate init(authenticationView: PredixAuthenticationView) {
        super.init()
        self.authenticationView = authenticationView
    }
    
    
    override func performRefresh(token: String) {
        authenticationView?.showActivitySpinner()
        super.performRefresh(token: token)
    }
}

@objc public protocol PredixAuthenticationViewDelegate: NSObjectProtocol {
    @objc optional func signInPressed()
    @objc optional func authenticationComplete(success: Bool, error: Error?)
}

//Authenticating logic
extension PredixAuthenticationView {
    open func beginAuthentication() {
        guard !authenticationInProgress else {
            return
        }
        authenticationInProgress = true
        
        if configuration.baseURL == nil, let serverUrlString = Bundle.main.object(forInfoDictionaryKey: "server_url") as? String {
            configuration.baseURL = URL(string: serverUrlString)
        }
        
        authenticationManager = AuthenticationManager(configuration: configuration)
        authenticationManager?.authorizationHandler = UAAAuthorizationHandler()
        if onelineHandler == nil {
            onelineHandler = UAAServiceAuthenticationHandler()
            onelineHandler?.authenticationServiceDelegate = self
            onelineHandler?.refreshAuthenticationHandler = AuthenticationViewRefreshHandler(authenticationView: self)
        }
        authenticationManager?.onlineAuthenticationHandler = onelineHandler
        
        authenticationManager?.authenticate { status in
            DispatchQueue.main.async {[weak self] in
                self?.hideActivitySpinner()
                if case AuthenticationManager.AuthenticationCompletionStatus.failed(let error) = status {
                    self?.delegate?.authenticationComplete?(success: false, error: error)
                } else {
                    self?.delegate?.authenticationComplete?(success: true, error: nil)
                }
            }
        }
    }
    
    @objc func signIn(sender: Any) {
        if let signInFunction = self.delegate?.signInPressed {
            signInFunction()
        } else {
            showActivitySpinner()
            credentialProvider?(emailTextField.text ?? "", passwordTextField.text ?? "")
        }
    }
}

extension PredixAuthenticationView: ServiceBasedAuthenticationHandlerDelegate {
    public func authenticationHandler(_ authenticationHandler: AuthenticationHandler, provideCredentialsWithCompletionHandler completionHandler: @escaping AuthenticationCredentialsProvider) {
        credentialProvider = completionHandler
    }
    
    public func authenticationHandler(_ authenticationHandler: AuthenticationHandler, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivitySpinner()
            self?.delegate?.authenticationComplete?(success: false, error: error)
        }
    }
    
    public func authenticationHandlerProvidedCredentialsWereInvalid(_ authenticationHandler: AuthenticationHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivitySpinner()
            let error = NSError(domain:  PredixMobileErrorDomain.authentication.description, code: 999, userInfo: [NSLocalizedDescriptionKey: "credentials were invalid"])
            self?.delegate?.authenticationComplete?(success: false, error: error)
        }
    }
}

extension PredixAuthenticationView: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        self.checkIfKeyboardIsBlockingTextField()
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.signIn(sender: self)
        }
        
        return true
    }
    
    func checkIfKeyboardIsBlockingTextField() {
        if let textFieldFrame = activeTextField?.frame, let keyboardFrame = keyboardRect, textFieldFrame.intersects(keyboardFrame) {
            var size = self.bounds.size
            size.height += keyboardFrame.size.height
            self.scrollView.contentSize = size
            let orgin = CGPoint(x: 0, y: keyboardRect!.intersection(textFieldFrame).size.height + textFieldFrame.size.height)
            self.scrollView.setContentOffset(orgin, animated: true)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        if let keyboardRect = self.keyboardRect {
            self.keyboardRect = self.scrollView.convert(keyboardRect, from: nil)
        }
        self.checkIfKeyboardIsBlockingTextField()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.disableScrolling()
    }
    
    @objc func hideKeyboard() {
        self.activeTextField?.resignFirstResponder()
        self.disableScrolling()
    }
    
    func disableScrolling() {
        self.scrollView.contentSize = CGSize()
        self.scrollView.setContentOffset(CGPoint(), animated: true)
    }
}
