//
//  Layer0.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 02.04.2023.
//

import UIKit

class Layer1: CAGradientLayer {
    override init() {
        super.init()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        setupLayer()
    }
    
    private func setupLayer() {
        self.colors = [
            UIColor(red: 0.487, green: 0.863, blue: 0.84, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
          ]
        self.locations = [0, 0.91]
        self.startPoint = CGPoint(x: 0.25, y: 0.5)
        self.endPoint = CGPoint(x: 0.75, y: 0.5)
        self.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -0.47, b: 1.06, c: -1.06, d: -0.13, tx: 1.03, ty: 0.06))
    }
}
