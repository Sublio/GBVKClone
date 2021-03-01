//
//  DM+UIIMage.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 26.02.2021.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
