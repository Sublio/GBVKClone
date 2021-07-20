//
//  UIViewController+SignOut.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.07.2021.
//

import UIKit

extension UIViewController {
    @objc func signOut() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        view.window?.rootViewController = vc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        KeychainService.removeToken(service: "tokenStorage")
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
