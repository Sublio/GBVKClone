//
//  ViewController+KingFisher.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.05.2021.
//

import Foundation
import Kingfisher
import UIKit

extension UIViewController {
    func downloadImage(with urlString: String, imageCompletionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL.init(string: urlString) else {
            return  imageCompletionHandler(nil)
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(nil)
            }
        }
    }
}
