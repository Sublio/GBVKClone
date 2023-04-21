//
//  UIViewController+TopMostViewControllerSelector.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.04.2023.
//

import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? self
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? self
        }
        return self
    }
}

