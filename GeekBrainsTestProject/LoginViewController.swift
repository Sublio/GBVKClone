//
//  ViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.01.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private var testLogin = ""
    private var testPassword = ""

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
}
