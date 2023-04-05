//
//  ViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.01.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    private var testLogin = ""
    private var testPassword = ""
    private var bottomButtonConstrains = NSLayoutConstraint()

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureBackgroundLayers()
        let loginLabel = LoginLabel(parentView: view)
        let logPassLabel = LoginPassLabel(parentView: view,aboveView: loginLabel, text: "User Name")
        let loginTextField = CustomLoginTextField(parentView: view, aboveView: logPassLabel, placeholder: "",topAnchorConstant: 0)
        let passLabel = LoginPassLabel(parentView: view, aboveView: loginTextField, text: "Password", width: 165, height: 31,topAnchorConstant: 1)
        let passTextField = CustomLoginTextField(parentView: view,aboveView: passLabel, placeholder: "", isPasswordField: true, topAnchorConstant: 0)
        let forgotPassButton = CustomForgotPasswordButton(parentView: view,aboveView: passTextField, topAnchorConstant: 0)
        let loginButton = LoginSignupButton(parentView: view, aboveView: forgotPassButton, title: "LOG IN", topAnchorConstant: 0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        if loginTextField.text == testLogin && passwordTextField.text == testPassword {
            return
        } else {

            let alert = UIAlertController(title: "Error", message: "Wrong login or password", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }

    func animateTextFields() {
        let offset = view.bounds.width
        loginTextField.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordTextField.transform =  CGAffineTransform(translationX: offset, y: 0)

        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseInOut, animations: {
            self.loginTextField.transform = .identity
            self.passwordTextField.transform = .identity
        }, completion: nil)
    }

    func animateSubmitButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass =   2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = .backwards
        self.loginButton.layer.add(animation, forKey: nil)
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
}
