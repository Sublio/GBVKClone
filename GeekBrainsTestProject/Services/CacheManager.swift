//
//  CacheManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 27.05.2021.
//

import Foundation
import Alamofire
import UIKit

class CacheManager {
    private var images = [String: UIImage]()

    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60

    private let container: DataReloadable

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }

        return pathName
    }()

    private func getFilePath(url: String) -> String? {
        guard let cachedDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil}
        let hashName = url.split(separator: "/").last ?? "default"
        return cachedDirectory.appendingPathComponent(CacheManager.pathName + "/" + hashName).path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImagesFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil}
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    private func loadPhoto(at indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }

    func photo(at indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImagesFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(at: indexPath, byUrl: url)
        }
        return image
    }
}

private protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension CacheManager {
    private class Table: DataReloadable {
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .automatic)
        }

        let table: UITableView

        init (table: UITableView) {
            self.table = table
        }
    }
}
