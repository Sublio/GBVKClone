//
//  GradientView.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 12.03.2021.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let theLayer = self.layer as? CAGradientLayer else {
            return
        }
        let startColor = UIColor.init(hex:  "7CDCD6",alpha: 1)
        let finishColor = UIColor.init(hex: "ECD0D0" ,alpha: 1)

        theLayer.colors = [startColor.cgColor, finishColor.cgColor]
        theLayer.locations = [0.0, 0.5]
        theLayer.startPoint = .init(x: 1, y: 0)
        theLayer.endPoint   = .init(x: 0, y: 1)
        theLayer.frame = self.bounds
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
