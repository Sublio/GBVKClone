//
//  NavigationControllerDelegate.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interActiveTransition = CustomInteractiveTransition()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interActiveTransition.viewController = toVC
            return NavigationTransitionPush()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interActiveTransition.viewController = toVC
            }
            return NavigationTransitionPop()
        }
        return nil
    }

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
                              -> UIViewControllerInteractiveTransitioning? {
        return interActiveTransition.hasStarted ? interActiveTransition : nil
    }
}
