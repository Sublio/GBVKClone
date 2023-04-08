import UIKit

class LoginSignupButton: UIButton {
    
    init(parentView: UIView, aboveView: UIView, title: String, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat, widthAnchorConstant: CGFloat = 119, heightAnchorConstant: CGFloat = 36) {
        super.init(frame: .zero)
        setupButton(title: title)
        addGestureRecognizer()

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
        setupGradientLayers()
        applyCornerRadius()
    }
    
    private func setupGradientLayers() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.416, green: 0.85, blue: 0.798, alpha: 1).cgColor,
            UIColor(red: 0.664, green: 0.925, blue: 0.622, alpha: 1).cgColor,
        ]
        gradientLayer.locations = [0, 0.35, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func applyCornerRadius() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 9).cgPath
        self.layer.mask = maskLayer
    }
        
    private func setupButton(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    private func addGestureRecognizer() {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
            self.addGestureRecognizer(tapGestureRecognizer)
        }
        
    @objc private func buttonTapped() {
        print("Button tapped")
        // Add your custom action here
    }
}

