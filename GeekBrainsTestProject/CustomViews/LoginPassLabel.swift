//
//  LoginPassLabel.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 03.04.2023.
//

import UIKit

class LoginPassLabel: UILabel {
    init(parentView: UIView, aboveView: UIView) {
        super.init(frame: .zero)
        setupLabel()

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 73),
            self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 12),
            self.heightAnchor.constraint(equalToConstant: 31),
            self.widthAnchor.constraint(equalToConstant: 192)
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
