//
//  CustomGradientButton.swift
//  GeekBrainsTestProject
//
//  Created by Your Name on 04.04.2023.
//

import UIKit

class LoginSignupButton: UIButton {
    
    init(parentView: UIView, aboveView: UIView, title: String, width: CGFloat = 99, height: CGFloat = 26, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat, widthAnchorConstant: CGFloat = 99, heightAnchorConstant: CGFloat = 26) {
        super.init(frame: .zero)
        setupButton(title:"LOG IN")

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: centerXOffset),
            self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: topAnchorConstant),
            self.widthAnchor.constraint(equalToConstant: widthAnchorConstant),
            self.heightAnchor.constraint(equalToConstant: heightAnchorConstant)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(title: "LOG IN")
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
//            setupGradientLayers()
    }
    
    private func setupGradientLayers() {
          let layer0 = CAGradientLayer()
          layer0.colors = [
            UIColor(red: 0.664, green: 0.925, blue: 0.622, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
          ]
          layer0.locations = [0.74, 1]
          layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
          layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
          layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.86, b: 4.27, c: -4.27, d: 12.52, tx: 2.63, ty: -6.26))
          layer0.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
          layer0.position = self.center
          self.layer.addSublayer(layer0)

          let layer1 = CAGradientLayer()
          layer1.colors = [
            UIColor(red: 0.416, green: 0.85, blue: 0.798, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
          ]
          layer1.locations = [0, 1]
          layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
          layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
          layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.75, b: 3.92, c: -3.92, d: 10.91, tx: 2.46, ty: -5.46))
          layer1.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
          layer1.position = self.center
          self.layer.addSublayer(layer1)
      }
    
    private func setupButton(title:String) {
        self.backgroundColor = .white
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 9
    }
}
