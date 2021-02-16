//
//  DMSearchBar.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 15.02.2021.
//

import UIKit

class DMSearchBar: UISearchBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        barTintColor = .clear
        tintColor = .clear
        isTranslucent = true
        backgroundImage = UIImage()
    }
}
