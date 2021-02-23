//
//  CloudLoadingView.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.02.2021.
//

import UIKit

class CloudLoadingView: UIView {

 
    override func draw(_ rect: CGRect) {
        //General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //Color Declarations
        let fillColor = UIColor.blueZero

        context.saveGState()
        context.translateBy(x: 0, y: 0.44)
        context.scaleBy(x: 0.1, y: 0.1)

        //Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 406.41, y: 136.15))
        bezierPath.addCurve(to: CGPoint(x: 358.4, y: 104.32), controlPoint1: CGPoint(x: 394.01, y: 120.89), controlPoint2: CGPoint(x: 377.13, y: 109.74))
        bezierPath.addCurve(to: CGPoint(x: 250.07, y: 0), controlPoint1: CGPoint(x: 356.24, y: 46.43), controlPoint2: CGPoint(x: 308.48, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 181.97, y: 24.06), controlPoint1: CGPoint(x: 225.35, y: 0), controlPoint2: CGPoint(x: 201.16, y: 8.55))
        bezierPath.addCurve(to: CGPoint(x: 146.8, y: 75.38), controlPoint1: CGPoint(x: 165.49, y: 37.39), controlPoint2: CGPoint(x: 153.22, y: 55.36))
        bezierPath.addCurve(to: CGPoint(x: 119.55, y: 70.12), controlPoint1: CGPoint(x: 138.17, y: 71.92), controlPoint2: CGPoint(x: 128.89, y: 70.12))
        bezierPath.addCurve(to: CGPoint(x: 46.13, y: 143.02), controlPoint1: CGPoint(x: 79.24, y: 70.12), controlPoint2: CGPoint(x: 46.41, y: 102.77))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 214.54), controlPoint1: CGPoint(x: 18.33, y: 155.63), controlPoint2: CGPoint(x: 0, y: 183.71))
        bezierPath.addCurve(to: CGPoint(x: 78.49, y: 293.03), controlPoint1: CGPoint(x: 0, y: 257.82), controlPoint2: CGPoint(x: 35.21, y: 293.03))
        bezierPath.addLine(to: CGPoint(x: 331.67, y: 293.03))
        bezierPath.addCurve(to: CGPoint(x: 427.91, y: 196.79), controlPoint1: CGPoint(x: 384.74, y: 293.03), controlPoint2: CGPoint(x: 427.91, y: 249.85))
        bezierPath.addCurve(to: CGPoint(x: 406.41, y: 136.15), controlPoint1: CGPoint(x: 427.91, y: 174.75), controlPoint2: CGPoint(x: 420.27, y: 153.22))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 331.67, y: 278.03))
        bezierPath.addLine(to: CGPoint(x: 78.49, y: 278.03))
        bezierPath.addCurve(to: CGPoint(x: 15, y: 214.54), controlPoint1: CGPoint(x: 43.48, y: 278.03), controlPoint2: CGPoint(x: 15, y: 249.54))
        bezierPath.addCurve(to: CGPoint(x: 56.4, y: 155), controlPoint1: CGPoint(x: 15, y: 188.12), controlPoint2: CGPoint(x: 31.64, y: 164.19))
        bezierPath.addCurve(to: CGPoint(x: 61.27, y: 147.47), controlPoint1: CGPoint(x: 59.51, y: 153.84), controlPoint2: CGPoint(x: 61.49, y: 150.78))
        bezierPath.addCurve(to: CGPoint(x: 61.13, y: 143.54), controlPoint1: CGPoint(x: 61.17, y: 145.95), controlPoint2: CGPoint(x: 61.13, y: 144.7))
        bezierPath.addCurve(to: CGPoint(x: 119.55, y: 85.12), controlPoint1: CGPoint(x: 61.13, y: 111.33), controlPoint2: CGPoint(x: 87.33, y: 85.12))
        bezierPath.addCurve(to: CGPoint(x: 148.01, y: 92.54), controlPoint1: CGPoint(x: 129.5, y: 85.12), controlPoint2: CGPoint(x: 139.34, y: 87.69))
        bezierPath.addCurve(to: CGPoint(x: 154.72, y: 92.85), controlPoint1: CGPoint(x: 150.07, y: 93.69), controlPoint2: CGPoint(x: 152.56, y: 93.81))
        bezierPath.addCurve(to: CGPoint(x: 158.98, y: 87.65), controlPoint1: CGPoint(x: 156.88, y: 91.88), controlPoint2: CGPoint(x: 158.46, y: 89.96))
        bezierPath.addCurve(to: CGPoint(x: 191.4, y: 35.73), controlPoint1: CGPoint(x: 163.59, y: 67.34), controlPoint2: CGPoint(x: 175.1, y: 48.9))
        bezierPath.addCurve(to: CGPoint(x: 250.07, y: 15), controlPoint1: CGPoint(x: 207.93, y: 22.36), controlPoint2: CGPoint(x: 228.77, y: 15))
        bezierPath.addCurve(to: CGPoint(x: 343.48, y: 108.41), controlPoint1: CGPoint(x: 301.57, y: 15), controlPoint2: CGPoint(x: 343.48, y: 56.9))
        bezierPath.addCurve(to: CGPoint(x: 343.46, y: 109.73), controlPoint1: CGPoint(x: 343.48, y: 108.85), controlPoint2: CGPoint(x: 343.47, y: 109.29))
        bezierPath.addLine(to: CGPoint(x: 343.45, y: 110.03))
        bezierPath.addCurve(to: CGPoint(x: 349.33, y: 117.48), controlPoint1: CGPoint(x: 343.39, y: 113.59), controlPoint2: CGPoint(x: 345.85, y: 116.71))
        bezierPath.addCurve(to: CGPoint(x: 394.76, y: 145.61), controlPoint1: CGPoint(x: 367.09, y: 121.41), controlPoint2: CGPoint(x: 383.22, y: 131.4))
        bezierPath.addCurve(to: CGPoint(x: 412.91, y: 196.79), controlPoint1: CGPoint(x: 406.47, y: 160.01), controlPoint2: CGPoint(x: 412.91, y: 178.19))
        bezierPath.addCurve(to: CGPoint(x: 331.67, y: 278.03), controlPoint1: CGPoint(x: 412.91, y: 241.58), controlPoint2: CGPoint(x: 376.47, y: 278.03))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blueZero.cgColor
        shapeLayer.strokeColor = UIColor.blueOne.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        bezierPath.apply(CGAffineTransform(scaleX: 0.1, y: 0.1))
        shapeLayer.path = bezierPath.cgPath
        
        //animation for shapeLayer
        // 0.515 - полный круг анимации
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 0.515 // увеличивать на динамическиую константу
        strokeEndAnimation.speed = 0.2
        strokeEndAnimation.repeatCount = Float.infinity
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.0 // уменьшать на динамическую константу
        strokeStartAnimation.toValue = 0.400
        strokeStartAnimation.speed = 0.2
        strokeStartAnimation.repeatCount = Float.infinity
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        
        shapeLayer.add(strokeStartAnimation, forKey: nil)
        shapeLayer.add(strokeEndAnimation, forKey: nil)
        
        layer.addSublayer(shapeLayer)
        
        context.restoreGState()
    }
    
    override func layoutSubviews() {
        backgroundColor = .clear
    }
}
