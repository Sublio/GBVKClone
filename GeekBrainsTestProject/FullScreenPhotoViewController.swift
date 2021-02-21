//
//  FullScreenPhotoViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 20.02.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    let photos = [
                  UIImage(named: "face1"),
                  UIImage(named: "face2"),
                  UIImage(named: "face3"),
                  UIImage(named: "face4")
                ]
    
    var imageView: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = imageView {
            image.frame = UIScreen.main.bounds
            image.backgroundColor = .black
            image.contentMode = .scaleAspectFit
            image.isUserInteractionEnabled = true
            self.view.addSubview(image)
        }
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGestureRecognizerLeft.direction = .left
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGestureRecognizerRight.direction = .right
        self.imageView?.addGestureRecognizer(swipeGestureRecognizerRight)
        self.imageView?.addGestureRecognizer(swipeGestureRecognizerLeft)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        let randomInt = Int.random(in: 0...3)
        self.imageView?.image = photos[randomInt]
    }
}
