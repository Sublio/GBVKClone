//
//  LoginLabel.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 02.04.2023.
//

import UIKit

class LoginLabel: UILabel {
    
    init(parentView: UIView) {
        super.init(frame: .zero)
        setupLabel()

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 109),
            self.heightAnchor.constraint(equalToConstant: 38),
            
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 142),
//            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -420)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        self.frame = CGRect(x: 0, y: 0, width: 109, height: 38)
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.font = UIFont(name: "Roboto-Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        self.textAlignment = .center
        self.attributedText = NSMutableAttributedString(string: "LOG IN ", attributes: [NSAttributedString.Key.kern: 3.96, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
