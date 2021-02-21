//
//  FullScreenPhotoViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 20.02.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    let photos = [
                  UIImage(named: "face1")!,
                  UIImage(named: "face2")!,
                  UIImage(named: "face3")!
                ]
    
    var currentImage: UIImageView!
    
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
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        let randomInt = Int.random(in: 0...2)
        self.currentImage?.image = photos[randomInt]
    }
    
    private func setupImages(_ images: [UIImage]) {
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: scrollView.bounds.minY-20, width: scrollView.frame.width, height: scrollView.frame.height)
            currentImage = imageView
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipeGestureRecognizerLeft.direction = .left
            let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipeGestureRecognizerRight.direction = .right
            imageView.addGestureRecognizer(swipeGestureRecognizerRight)
            imageView.addGestureRecognizer(swipeGestureRecognizerLeft)
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            scrollView.addSubview(imageView)
            scrollView.delegate = self
        }
    }
}
