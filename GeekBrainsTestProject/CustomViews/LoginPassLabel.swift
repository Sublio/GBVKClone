//
//  LoginPassLabel.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 03.04.2023.
//

import UIKit

class LoginPassLabel: UILabel {
    init(parentView: UIView, aboveView: UIView, width: CGFloat = 165, height: CGFloat = 31, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat = 12) {
        super.init(frame: .zero)
        setupLabel()

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: centerXOffset),
            self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: topAnchorConstant),
            self.heightAnchor.constraint(equalToConstant: height),
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        self.frame = CGRect(x: 0, y: 0, width: 165, height: 31)
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        self.font = UIFont(name: "Roboto-Regular", size: 12)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.06
        // Line height: 15 pt
        self.attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
