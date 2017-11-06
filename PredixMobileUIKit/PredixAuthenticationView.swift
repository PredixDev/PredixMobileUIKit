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

/**
 Provides an authentication view that represents the default Predix UAA authentication view.
 
 The authentication view is intended to handle most of the interactions with UAA for you using a native UI form.  Simply provider your configuration and tell
 the PredixAuthenticationView to start authentication.
 
 *NOTE:*  The baseURL, clientId and clientSecret can be defined in your info.plist instead of in code using the following keys: server_url, client_id and client_secret
 
 Example usage from Interface builder:
 
 class ViewController: UIViewController, PredixAuthenticationViewDelegate {
 @IBOutlet weak var authenticationView: PredixAuthenticationView!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 var configuration = AuthenticationManagerConfiguration()
 configuration.baseURL = URL(string: "https://youruaahost.com")
 configuration.clientId = "a clientID"
 configuration.clientSecret = "a client secret"
 
 authenticationView.configuration = configuration
 authenticationView.beginAuthentication()
 }
 
 func authenticationComplete(success: Bool, error: Error?) {
 //Code you want to execute when Authentication has completed
 }
 }
 */
@IBDesignable
open class PredixAuthenticationView: UIView {
    private var keyboardRect: CGRect?
    private var firstSet = true
    private var credentialProvider: AuthenticationCredentialsProvider?
    private var footerLabel: UILabel = UILabel()
    
    internal private(set) var scrollView: UIScrollView = UIScrollView()
    internal private(set) var activeTextField: UITextField?
    internal private(set) var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    ///Indicates if authentication is in progress
    open private(set) var authenticationInProgress = false
    ///The title image that will be displayed above the email filed
    open let titleImageView: UIImageView = UIImageView()
    ///The email text filed used by the authentication view
    open let emailTextField: UITextField = UITextField()
    ///The password text filed used by the authentication view
    open let passwordTextField: UITextField = UITextField()
    ///The sign-in button used by the authentication view
    open let signInButton: UIButton = UIButton(type: .system)
    ///An authentication configuration to be used with the underlying authentication manager
    open var configuration: AuthenticationManagerConfiguration = AuthenticationManagerConfiguration()
    ///A ServiceBasedAuthenticationHandler to use with the authentication manager *defaults to UAAServiceAuthenticationHandler*
    open var onlineHandler: ServiceBasedAuthenticationHandler? {
        didSet {
            authenticationManager?.onlineAuthenticationHandler = onlineHandler
        }
    }
    ///The authentication manager that is used by the PredixAuthenticationView to authenticate with Predix UAA
    open private(set) var authenticationManager: AuthenticationManager?
    
    ///Title image you want to use for the title header that is displayed above the email text field
    @IBInspectable
    open var titleImage: UIImage? = UIImage(named: "predixTitle.png", in: Bundle(for: PredixAuthenticationView.self), compatibleWith: nil) {
        didSet {
            titleImageView.image = titleImage
        }
    }
    
    ///The PredixAuthenticationViewDelegate
    @IBOutlet
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
        let fieldResizeMask: UIViewAutoresizing = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        setupScrollView(with: baseRect)
        setupTitleImage(with: CGRect(x: baseInsetX, y: top, width: width, height: 56), autoresizingMask: fieldResizeMask)
        setupEmailTextField(with: CGRect(x: baseInsetX, y: top + fieldSpacing, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupPasswordTextField(with: CGRect(x: baseInsetX, y: top + fieldSpacing * 2, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupSignInButton(with: CGRect(x: baseInsetX, y: top + fieldSpacing * 3, width: width, height: fieldHeight), autoresizingMask: fieldResizeMask)
        setupFooter(with: CGRect(x: 4, y: baseRect.size.height - 30, width: baseRect.size.width - 8, height: 24))

        addSubview(scrollView)
    }
    /// :nodoc:
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

internal class AuthenticationViewRefreshHandler: UAARefreshAuthenticationHandler {
    private weak var authenticationView: PredixAuthenticationView?
    
    internal init(authenticationView: PredixAuthenticationView) {
        super.init()
        self.authenticationView = authenticationView
    }
    
    override internal func performRefresh(token: String) {
        authenticationView?.showActivitySpinner()
        super.performRefresh(token: token)
    }
}
/**
 An delegate that works with the PredixAuthenticationView that allows an implementer to be notified when certain actions take place during the authentication process
 */
@objc public protocol PredixAuthenticationViewDelegate: NSObjectProtocol {
    /**
     Called when the user presses the sign in button.
     
     Overriding this delegate method requires an implementer to take control of all sign in actions for the authentication manager.  The PredixAuthenticationView will stop doing sign-in actions
     when this delegate method is implemented.
     */
    @objc optional func signInPressed()
    /**
     Provides the delegate with the ability to do an action when authentication is completed.
     
     - parameters:
     - success: Indicates is authentication was successful or not
     - error: If an error was encountered during authentication the error property will give an indication why authentication failed or encountered an error
     */
    @objc optional func authenticationComplete(success: Bool, error: Error?)
}

// MARK: - Authenticating logic
/// :nodoc:
extension PredixAuthenticationView {
    /// let the view know it is OK to start the authentication process
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
        if onlineHandler == nil {
            onlineHandler = UAAServiceAuthenticationHandler()
            onlineHandler?.authenticationServiceDelegate = self
            onlineHandler?.refreshAuthenticationHandler = AuthenticationViewRefreshHandler(authenticationView: self)
        }
        authenticationManager?.onlineAuthenticationHandler = onlineHandler
        
        authenticationManager?.authenticate { status in
            self.authenticationComplete(status: status)
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
    
    internal func authenticationComplete(status: AuthenticationManager.AuthenticationCompletionStatus) {
        Utilities.runOnMainThread { [weak self] in
            self?.hideActivitySpinner()
            if case AuthenticationManager.AuthenticationCompletionStatus.failed(let error) = status {
                self?.delegate?.authenticationComplete?(success: false, error: error)
            } else {
                self?.delegate?.authenticationComplete?(success: true, error: nil)
            }
        }
    }
}

/// :nodoc:
extension PredixAuthenticationView: ServiceBasedAuthenticationHandlerDelegate {
    /// :nodoc:
    public func authenticationHandler(_ authenticationHandler: AuthenticationHandler, provideCredentialsWithCompletionHandler completionHandler: @escaping AuthenticationCredentialsProvider) {
        credentialProvider = completionHandler
    }
    
    /// :nodoc:
    public func authenticationHandler(_ authenticationHandler: AuthenticationHandler, didFailWithError error: Error) {
        Utilities.runOnMainThread { [weak self] in
            self?.hideActivitySpinner()
            self?.delegate?.authenticationComplete?(success: false, error: error)
        }
    }
    
    /// :nodoc:
    public func authenticationHandlerProvidedCredentialsWereInvalid(_ authenticationHandler: AuthenticationHandler) {
        Utilities.runOnMainThread { [weak self] in
            self?.hideActivitySpinner()
            let error = NSError(domain:  PredixMobileErrorDomain.authentication.description, code: 999, userInfo: [NSLocalizedDescriptionKey: "credentials were invalid"])
            self?.delegate?.authenticationComplete?(success: false, error: error)
        }
    }
}

/// :nodoc:
extension PredixAuthenticationView: UITextFieldDelegate {
    /// :nodoc:
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        self.checkIfKeyboardIsBlockingTextField()
        
        return true
    }
    
    /// :nodoc:
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
        self.scrollView.setContentOffset(CGPoint(x: 0, y: self.bounds.origin.y), animated: true)
    }
}
