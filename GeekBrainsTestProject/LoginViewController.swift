//
//  ViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.01.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private var testLogin = "Test"
    private var testPassword = "Test"

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGradientToView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTextFields()
        animateSubmitButton()
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
    
    func setGradientToView() {
        let hexColors: [CGColor] = [
            UIColor.blueZero.cgColor,
            UIColor.white.cgColor
        ]

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = hexColors
        gradientLayer.locations = [0.0, 0.5]
        // Vertical mode for gradient
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint   = .init(x: 0, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
