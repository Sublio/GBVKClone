//
//  ViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.01.2021.
//

import UIKit
import SwiftyVK

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var bottomButtonConstrains = NSLayoutConstraint()
    
    private var loginLabel: LoginLabel!
    private var logPassLabel: LoginPassLabel!
    private var loginTextField: CustomLoginTextField!
    private var passLabel: LoginPassLabel!
    private var passTextField: CustomLoginTextField!
    private var forgotPassButton: CustomForgotPasswordButton!
    private var loginButton: LoginSignupButton!
    private var orLabel: LoginPassLabel!
    private var signUpButton: LoginSignupButton!
    
    private var activityIndicator: UIActivityIndicatorView?
    private var greyBackgroundView: UIView?
    
    let VKDelegate = VKDelegateExample()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginButtonTapped))
        loginButton.addGestureRecognizer(tapGestureRecognizer)
        if VK.needToSetUp {
            // Set up SwiftyVK
            VK.setUp(appId: AppConfig.vkAppId, delegate: self.VKDelegate)
        }
    }
    
    
    private func setUpUI(){
        self.configureBackgroundLayers()
        loginLabel = LoginLabel(parentView: view)
        logPassLabel = LoginPassLabel(parentView: view,aboveView: loginLabel, text: "User Name", textAlignment: .left)
        loginTextField = CustomLoginTextField(parentView: view, aboveView: logPassLabel, placeholder: "",topAnchorConstant: 0)
        passLabel = LoginPassLabel(parentView: view, aboveView: loginTextField, text: "Password", width: 165, height: 31,topAnchorConstant: 1, textAlignment: .left)
        passTextField = CustomLoginTextField(parentView: view,aboveView: passLabel, placeholder: "", isPasswordField: true, topAnchorConstant: 0)
        forgotPassButton = CustomForgotPasswordButton(parentView: view,aboveView: passTextField, topAnchorConstant: 0, topInset: 2, bottomInset: 2)
        loginButton = LoginSignupButton(parentView: view, aboveView: forgotPassButton, title: "LOG IN", topAnchorConstant: 0)
        orLabel = LoginPassLabel(parentView: view, aboveView: loginButton, text: "OR", topAnchorConstant: 0, textAlignment: .center)
        signUpButton = LoginSignupButton(parentView: view, aboveView: orLabel, title: "SIGN UP", topAnchorConstant: 0)
    }

    func showLoadingIndicator(withInterval interval: Double) {

        let layout = CAReplicatorLayer()
        layout.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 25, height: 11)
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 7, height: 7)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor
        layout.addSublayer(circle)
        layout.instanceCount = 3
        layout.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.2
        animation.duration = 1
        animation.repeatCount = 20
        circle.add(animation, forKey: nil)
        layout.instanceDelay = animation.duration / Double(layout.instanceCount)
        layout.name = "loading animation"
        self.view.layer.addSublayer(layout)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [self] in
            self.hideLoadingIndicator()
        }
    }

    func hideLoadingIndicator() {
        if let sublayers = view.layer.sublayers {
            for layer in sublayers {
                if layer.name == "loading animation"{
                    layer.removeFromSuperlayer()
                }
            }
        }
    }

    func showCloudAnimation(withInterval interval: Double) {
        let cloud = CloudLoadingView(frame: CGRect(origin: CGPoint(x: self.view.frame.size.width/2-20, y: self.view.frame.size.height/2-20), size: CGSize(width: 50, height: 50)))
        self.view.addSubview(cloud)

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [] in
            cloud.removeFromSuperview()
        }
    }
    
    func configureBackgroundLayers(){
        self.view.backgroundColor = .white
        let layer0 = Layer0()
        let layer1 = Layer1()
        self.view.layer.compositingFilter = "darkenBlendMode"
        layer0.bounds = self.view.bounds
        layer0.position = self.view.center
        self.view.layer.addSublayer(layer0)
        layer1.bounds = self.view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer1.position = self.view.center
        self.view.layer.addSublayer(layer1)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            UIView.animate(withDuration: 0.3) {
                self.bottomButtonConstrains.constant -= keyboardSize.height + 20
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.bottomButtonConstrains.constant = -70
            self.view.layoutIfNeeded()
        }
    }

    // Login and Password TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil {
            showLoadingIndicator(withInterval: 3)
        }
    }
    
    func checkLoginPassFields(){
        if loginTextField.text == "" || passTextField.text == ""{
            AlertManager.shared.showAlert(title: "Email and/or password cannot be empty", message: "Please check your login and password", viewController: self) {
                    self.removeActivityIndicator()
                }
        }
    }
    
    @objc func loginButtonTapped() {
        //checkLoginPassFields()
        showActivityIndicator()
        VK.sessions.default.logIn(
              onSuccess: { response in
                // Start working with SwiftyVK session here
                  print(response)
                  if let token = VK.sessions.default.accessToken{
                      Session.shared.token = token.get()!
                  }
                  print(Session.shared.token)
                  DispatchQueue.main.async {
                      self.performSegue(withIdentifier: AppConfig.segueName, sender: nil)                  }
              },
              onError: { error in
                  print(error.localizedDescription)
                  if case VKError.authorizationCancelled = error {
                      // If the error is authorizationCancelled, simply return without showing the alert
                      DispatchQueue.main.async {
                          self.removeActivityIndicator()
                      }
                    return
                  }
                  // Otherwise, show the error alert
                  DispatchQueue.main.async {
                      AlertManager.shared.showAlert(title: "Login Error", message: error.localizedDescription, viewController: self)
                      self.removeActivityIndicator()
            }
        }
    )
}



    func showActivityIndicator() {
        // Create and configure the activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        // Add constraints for the activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // Create a UIView for the grey background
        let greyBackgroundView = UIView(frame: view.bounds)
        greyBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        greyBackgroundView.alpha = 0
        view.insertSubview(greyBackgroundView, belowSubview: activityIndicator)

        // Animate the grey background appearing
        UIView.animate(withDuration: 0.25) {
            greyBackgroundView.alpha = 1
        }

        // Start the activity indicator
        activityIndicator.startAnimating()

        // Save the activity indicator and grey background views to properties for later removal
        self.activityIndicator = activityIndicator
        self.greyBackgroundView = greyBackgroundView
    }
    
    func removeActivityIndicator() {
        // Stop the activity indicator and remove the grey background
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
        self.activityIndicator = nil
        self.greyBackgroundView?.removeFromSuperview()
        self.greyBackgroundView = nil
    }
}
