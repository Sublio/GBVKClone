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
        resetToInitialViewController()
    }
    
    func resetToInitialViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? LoginViewController else { return }
        view.window?.rootViewController = vc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
