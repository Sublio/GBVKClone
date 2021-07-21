//
//  Photo.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import SwiftyJSON

class Photo {

    var id: Int = 0
    var sizes: [PhotoSize] = []
    var album_id: Int = 0

    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.id = json["id"].intValue
        self.album_id = json["album_id"].intValue
        self.sizes = json["sizes"].arrayValue.compactMap { PhotoSize($0)}
    }

}

struct PhotoSize {
    let type: String
    let height: Int
    let width: Int
    let url: String

    init(_ json: JSON) {
        self.type = json["type"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["url"].stringValue
    }
}
