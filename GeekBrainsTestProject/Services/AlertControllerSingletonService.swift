//
//  AlertControllerSingletonService.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 10.04.2023.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(title: String, message: String, viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?() // Call the closure parameter
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

