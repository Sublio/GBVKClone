//
//  NavigationControllerDelegate.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.02.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return NavigationTransitionPush()
        } else if operation == .pop {
            return NavigationTransitionPop()
        }
        return nil
    }
}
