//
//  ViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.01.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    private var testLogin = "Test"
    private var testPassword = "Test"
    private var bottomButtonConstains = NSLayoutConstraint()

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let gradientView = GradientView(frame: self.view.bounds)
        self.view.insertSubview(gradientView, at: 0)
        bottomButtonConstains = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        bottomButtonConstains.isActive = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        animateTextFields()
        animateSubmitButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // showLoadingIndicator(withInterval: 3)
        // showCloudAnimation(withInterval: 10.0)
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

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [self] in
            cloud.removeFromSuperview()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            UIView.animate(withDuration: 0.3) {
                self.bottomButtonConstains.constant -= keyboardSize.height + 20
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.bottomButtonConstains.constant = -70
            self.view.layoutIfNeeded()
        }
    }

    // Login and Password TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
