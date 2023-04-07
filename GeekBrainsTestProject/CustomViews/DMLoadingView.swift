//
//  LoadingView.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 13.04.2021.
//

import UIKit

class DMLoadingView: UIView {
    private let spinningView = UIActivityIndicatorView()
    private let loadingLabel = UILabel()

    func setLoadingScreen(for tableView: UITableView, navigationController: UINavigationController) -> UIView {
            let loadingView = UIView()

            // Calculate dimensions and positions
            let width: CGFloat = 120
            let height: CGFloat = 30
            let tabBarHeight = CGFloat(49.0)
            let x = (tableView.frame.width / 2) - (width / 2)
            let y = (tableView.frame.height / 2) - (height / 2) - navigationController.navigationBar.frame.height
            let finalY = y - tabBarHeight
            loadingView.frame = CGRect(x: x, y: finalY, width: width, height: height)

            // Configure loading label
            configureLoadingLabel()

            // Configure spinner
            configureSpinningView()

            // Add text and spinner to the view
            loadingView.addSubview(spinningView)
            loadingView.addSubview(loadingLabel)

            return loadingView
        }

        func removeLoadingView() {
            spinningView.stopAnimating()
            spinningView.isHidden = true
            loadingLabel.isHidden = true
        }

        private func configureLoadingLabel() {
            loadingLabel.textColor = .gray
            loadingLabel.textAlignment = .center
            loadingLabel.text = "Loading..."
            loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        }

        private func configureSpinningView() {
            spinningView.style = .medium
            spinningView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            spinningView.startAnimating()
        }
}

