//
//  RoundedViewWithShadow.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 06.02.2021.
//

import UIKit

@IBDesignable class RoundedView: UIView {

    @IBInspectable var shadowColor: UIColor =  UIColor.darkGray
    @IBInspectable var shadowRadius: CGFloat = 2
    @IBInspectable var shadowOpacity: Float = 0.8

    var imageLayer: CALayer!
    var shadowLayer: CALayer!
    var image: UIImage? {
        didSet { refreshImage() }
    }

    func refreshImage() {
        if let imageLayer = imageLayer, let image = image {
            imageLayer.contents = image.cgImage
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if imageLayer == nil {
            let radius: CGFloat = 20, offset: CGFloat = 4

            let shadowLayer = CALayer()
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
            shadowLayer.shadowOffset = CGSize(width: offset, height: offset)
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            self.shadowLayer = shadowLayer
            layer.addSublayer(shadowLayer)

            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath

            imageLayer = CALayer()
            imageLayer.mask = maskLayer
            imageLayer.frame = bounds
            imageLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
            layer.addSublayer(imageLayer)
        }
        refreshImage()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startAvatarAnimation))
        self.addGestureRecognizer(gestureRecognizer)
    }

    @objc func startAvatarAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.75
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 0.5
        animation.duration = 4
        animation.speed = 0.3
        imageLayer.add(animation, forKey: nil)
        shadowLayer.add(animation, forKey: nil)
    }
}
