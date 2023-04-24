//
//  UIViewController+SignOut.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.07.2021.
//

import UIKit
import SwiftyVK

extension UIViewController {
    @objc func signOut() {
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        KeychainService.removeToken(service: "tokenStorage")
        if VK.sessions.default.state != .destroyed {
            VK.sessions.default.logOut()
        }

        // Find the top-most presented view controller
        var topViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }

        // Dismiss any presented view controllers
        topViewController?.dismiss(animated: true) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.showLoginViewController()
            }
        }
    }
}
