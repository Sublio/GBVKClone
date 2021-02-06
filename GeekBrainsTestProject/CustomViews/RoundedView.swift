//
//  RoundedViewWithShadow.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 06.02.2021.
//

import UIKit

@IBDesignable class RoundedView : UIView {
    
    @IBInspectable var shadowColor:UIColor =  UIColor.darkGray
    @IBInspectable var shadowRadius: CGFloat = 2
    @IBInspectable var shadowOpacity: Float = 0.8

    
    var imageLayer: CALayer!
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
               layer.addSublayer(shadowLayer)
               
               let maskLayer = CAShapeLayer()
               maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
               
               imageLayer = CALayer()
               imageLayer.mask = maskLayer
               imageLayer.frame = bounds
               imageLayer.backgroundColor = UIColor.red.cgColor
               imageLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
               layer.addSublayer(imageLayer)
           }
           refreshImage()
       }
}


