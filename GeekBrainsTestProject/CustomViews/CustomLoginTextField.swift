//
//  CustomLoginTextField.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 03.04.2023.
//

import UIKit

class CustomLoginTextField: UITextField {
    
    init(parentView: UIView, aboveView: UIView, placeholder: String, isPasswordField: Bool = false, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat = 223, widthAnchorConstant: CGFloat = 200, heightAnchorConstant: CGFloat = 30) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, isPasswordField: isPasswordField)

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
        setupTextField(placeholder: "", isPasswordField: false)
    }
    
    private func setupTextField(placeholder: String, isPasswordField: Bool) {
        self.borderStyle = .roundedRect
        self.font = UIFont.systemFont(ofSize: 16)
        self.placeholder = placeholder
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.returnKeyType = .done
        self.clearButtonMode = .whileEditing
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 6
        self.isSecureTextEntry = isPasswordField
    }
}

