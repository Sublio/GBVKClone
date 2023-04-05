//
//  CustomForgotPasswordButton.swift
//  GeekBrainsTestProject
//
//  Created by Your Name on 04.04.2023.
//

import UIKit

class CustomForgotPasswordButton: UIButton {
    
    init(parentView: UIView, aboveView: UIView, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat, widthAnchorConstant: CGFloat = 165, heightAnchorConstant: CGFloat = 31) {
        super.init(frame: .zero)
        setupButton()

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
        setupButton()
    }
    
    private func setupButton() {
        self.backgroundColor = .clear
        self.setTitleColor(UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1), for: .normal)
        self.titleLabel?.font = UIFont(name: "Roboto-Light", size: 11)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.06
        // Line height: 15 pt
        self.titleLabel?.textAlignment = .center
        self.setAttributedTitle(NSMutableAttributedString(string: "forget your password?", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]), for: .normal)
    }
}
