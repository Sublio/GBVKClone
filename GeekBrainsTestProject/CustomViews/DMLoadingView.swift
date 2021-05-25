//
//  LoadingView.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 13.04.2021.
//

import UIKit

class DMLoadingView: UIView {
    // Loading view section props
    let loadingView = UIView()
    let spinningView = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    // End of loading view section props
    
    func setLoadingScreen(for tableView: UITableView, navigationController: UINavigationController) -> UIView {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let tabBarHeight =  CGFloat(49.0)
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - ((navigationController.navigationBar.frame.height))
        let finalY = y - tabBarHeight
        loadingView.frame = CGRect(x: x, y: finalY, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinningView.style = .medium
        spinningView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinningView.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinningView)
        loadingView.addSubview(loadingLabel)
        return loadingView
    }
    
    func removeLoadingView() {
        self.spinningView.stopAnimating()
        self.spinningView.isHidden = true
        self.loadingLabel.isHidden = true
    }
}
