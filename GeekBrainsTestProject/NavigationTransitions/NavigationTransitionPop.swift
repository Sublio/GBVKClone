//
//  NavigationTransitionPop.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class NavigationTransitionPop: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = source.view.frame

        let translation2 = CGAffineTransform(translationX: -destination.view.frame.width, y: destination.view.frame.height)
        
        destination.view.transform = translation2.rotated(by: 90)
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModePaced,
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                                            let sourceBounds = source.view.bounds
                                            let rotationPoint = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
                                            source.view.layer.anchorPoint = CGPoint(x: -rotationPoint.x/sourceBounds.width, y: -rotationPoint.y/sourceBounds.height)
                                            let translation = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
                                            source.view.transform = translation
                                        }
                                        

                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                                            destination.view.transform = .identity

                                        }
            }) { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
    }
}
