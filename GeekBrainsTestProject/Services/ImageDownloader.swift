//
//  ImageDownloader.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.03.2021.
//

import UIKit

class ImageDownloaderService {

    func getData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
