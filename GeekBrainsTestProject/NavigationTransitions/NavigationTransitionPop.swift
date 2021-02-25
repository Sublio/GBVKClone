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
                                            let translation = CGAffineTransform(translationX: source.view.frame.width, y: -source.view.frame.height)
                                            
                                            source.view.transform = translation.rotated(by: -90)
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
