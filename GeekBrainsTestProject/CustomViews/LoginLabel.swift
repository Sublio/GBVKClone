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

        let labelWidth: CGFloat = 109
        let labelHeight: CGFloat = 38
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: labelWidth),
            self.heightAnchor.constraint(equalToConstant: labelHeight),
            
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 142),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.font = UIFont(name: "Roboto-Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        paragraphStyle.alignment = .center
        self.attributedText = NSMutableAttributedString(string: "LOG IN ", attributes: [NSAttributedString.Key.kern: 3.96, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
