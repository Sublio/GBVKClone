//
//  CustomLoginTextField.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 03.04.2023.
//

import UIKit

class CustomLoginTextField: UITextField {
    
    init(parentView: UIView, placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 223), // Adjust this constant as needed
            self.widthAnchor.constraint(equalToConstant: 165),
            self.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField(placeholder: "")
    }
    
    private func setupTextField(placeholder: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        self.font = UIFont.systemFont(ofSize: 16)
        self.placeholder = placeholder
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.returnKeyType = .done
        self.clearButtonMode = .whileEditing
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 6
    }
}
