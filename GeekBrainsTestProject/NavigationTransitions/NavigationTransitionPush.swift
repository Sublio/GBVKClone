//
//  NavigationTransitionPush.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class NavigationTransitionPush: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.backgroundColor = .black
        destination.view.frame = source.view.frame
        let translation2 = CGAffineTransform(translationX: destination.view.frame.width, y: -destination.view.frame.height)
        
        destination.view.transform = translation2.rotated(by: -180)
        

        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.75) {
                                                
                                                let rotationPoint = CGPoint(x: 0, y: 0)
                                                source.view.layer.anchorPoint = rotationPoint
                                                let translation = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                                                source.view.transform = translation
                                            }
                                            

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                                                destination.view.transform = .identity

                                            }
        } completion: { (finished) in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
