//
//  DM+UIColor.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 15.02.2021.
//

import UIKit

extension UIColor {

    static var blueZero: UIColor { return UIColor.init(rgb: 0x64E4FF) }
    static var blueOne: UIColor { return UIColor.init(rgb: 0x3A7BD5) }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
            let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            
            if hexString.hasPrefix("#") {
                scanner.currentIndex = hexString.index(after: hexString.startIndex)
            }
            
            var color: UInt64 = 0
            scanner.scanHexInt64(&color)
            
            let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(color & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
}
