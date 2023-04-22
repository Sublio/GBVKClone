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
        VK.sessions.default.logOut()
        let loginViewController = LoginViewController()
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }) {
            // Set the new root view controller
            window.rootViewController = loginViewController

            // Animate the transition
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}
