//
//  LikeCustomView.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 06.02.2021.
//

import UIKit

class LikedCustomView: UIView {
    
    var spriteImages = [UIImage]()
    var animatedOnce: Bool = false
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "tile00")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let likeCounter: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        
        addSubview(likeCounter)
        addSubview(imageView)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animate)))
        
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        likeCounter.heightAnchor.constraint(equalToConstant: 90).isActive = true
        likeCounter.widthAnchor.constraint(equalToConstant: 90).isActive = true
        likeCounter.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        likeCounter.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        for i in 0 ..< 29 {
            spriteImages.append(UIImage(named: "tile0\(i)")!)
        }
    }
    
    @objc func animate() {
        if animatedOnce {
            imageView.animationImages = spriteImages.reversed()
        } else {
            imageView.animationImages = spriteImages
        }
        imageView.animationDuration = 0.6
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
        if likeCounter.text == "0"{
            fadeLabelTransition(duration: 0.3)
            self.likeCounter.text = "1"
            self.likeCounter.textColor = .red
            imageView.image = UIImage(named: "tile028")
            animatedOnce = true
        } else {
            fadeLabelTransition(duration: 0.3)
            self.likeCounter.text = "0"
            self.likeCounter.textColor = .darkGray
            imageView.image = UIImage(named: "tile00")
            animatedOnce = false
        }
    }
    
    func fadeLabelTransition(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.type = .push
        animation.duration = duration
        self.likeCounter.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
