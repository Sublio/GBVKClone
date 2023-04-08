import UIKit

class LoginPassLabel: UILabel {
    
    init(parentView: UIView, aboveView: UIView, text: String, width: CGFloat = 200, height: CGFloat = 31, centerXOffset: CGFloat = 0, topAnchorConstant: CGFloat = 12, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        setupLabel(withText: text, alignment: textAlignment)

        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints(parentView: parentView, aboveView: aboveView, text: text, width: width, height: height, centerXOffset: centerXOffset, topAnchorConstant: topAnchorConstant)
    }

    private func setupConstraints(parentView: UIView, aboveView: UIView, text: String, width: CGFloat, height: CGFloat, centerXOffset: CGFloat, topAnchorConstant: CGFloat) {
        if text == "Password" {
            NSLayoutConstraint.activate([
                self.leftAnchor.constraint(equalTo: aboveView.leftAnchor),
                self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: topAnchorConstant),
                self.heightAnchor.constraint(equalToConstant: height),
                self.widthAnchor.constraint(equalToConstant: width)
            ])

        } else {
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: centerXOffset),
                self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: topAnchorConstant),
                self.heightAnchor.constraint(equalToConstant: height),
                self.widthAnchor.constraint(equalToConstant: width)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel(withText: "Username", alignment: textAlignment)
    }
    
    private func setupLabel(withText text: String, alignment: NSTextAlignment) {
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        self.font = UIFont(name: "Roboto-Regular", size: 12)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.06
        paragraphStyle.alignment = alignment
        self.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
