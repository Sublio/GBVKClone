//
//  Layer0.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 02.04.2023.
//

import UIKit

class Layer0: CALayer {
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
        backgroundColor = UIColor(red: 0.925, green: 0.815, blue: 0.815, alpha: 1).cgColor
    }
}
