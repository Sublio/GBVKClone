//
//  FullScreenPhotoViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 20.02.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {

    var photos = [
                  UIImage(named: "face1")!,
                  UIImage(named: "face2")!,
                  UIImage(named: "face3")!
                ]

    var selectedImageIndex: Int!

    let scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupImages((photos))
    }

    private func setupImages(_ images: [UIImage]) {
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: scrollView.bounds.minY-20, width: scrollView.frame.width, height: scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            scrollView.addSubview(imageView)
            scrollView.delegate = self
            scrollView.contentOffset = CGPoint(x: selectedImageIndex*375, y: 0)
        }
    }

    // ScrollView Delegate

     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.75
        animation.toValue = 1
        animation.stiffness = 75
        animation.mass = 0.5
        animation.duration = 2
        animation.speed = 0.3
        scrollView.layer.add(animation, forKey: nil)
    }
}
