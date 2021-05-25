//
//  MyCustomSegue.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class MyCustomSegue: UIStoryboardSegue {
    
    override func perform() {
        guard  let containerView = source.view.superview  else { return }
        
        let containerViewFrame = containerView.frame
        let sourceViewTargetFrame = CGRect(x: 0, y: -containerViewFrame.height, width: source.view.frame.width, height: source.view.frame.height)
        let destinationTargetFrame = source.view.frame
        
        containerView.addSubview(destination.view)
        
        destination.view.frame = CGRect(x: 0, y: containerViewFrame.height, width: source.view.frame.width, height: source.view.frame.height)
        
        UIView.animate(withDuration: 0.5) {
            self.source.view.frame = sourceViewTargetFrame
            self.destination.view.frame = destinationTargetFrame
        } completion: { (_) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
        
    }
}
