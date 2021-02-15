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
    static var grayZero: UIColor { return UIColor.init(rgb: 0x9B9B9B) }
    static var grayOne: UIColor { return UIColor.init(rgb: 0x424242) }
    
    convenience init(red: Int, green: Int, blue: Int) {
            assert(red >= 0 && red <= 255, "Invalid red component")
            assert(green >= 0 && green <= 255, "Invalid green component")
            assert(blue >= 0 && blue <= 255, "Invalid blue component")
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }

    convenience init(netHex: Int) {
            self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
        }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
