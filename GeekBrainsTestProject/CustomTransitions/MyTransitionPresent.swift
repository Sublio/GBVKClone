//
//  MyTransitionPresent.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class MyTransitionPresent: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        let containerViewFrame = transitionContext.containerView.frame

        let sourceViewTargeFrame = CGRect(x: 0, y: -containerViewFrame.height, width: source.view.frame.width, height: source.view.frame.height)
        let destinationViewTargetFrame = source.view.frame
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = CGRect(x: 0, y: containerViewFrame.height, width: source.view.frame.width, height: source.view.frame.height)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            source.view.frame = sourceViewTargeFrame
            destination.view.frame = destinationViewTargetFrame

        } completion: { (_) in
            source.removeFromParent()
            transitionContext.completeTransition(transitionContext.transitionWasCancelled)
        }

    }

    func animationEnded(_ transitionCompleted: Bool) {
        print("Transition has ended in present")
    }
}
