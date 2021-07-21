//
//  PhotoAlbum.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 06.07.2021.
//

import Foundation
import SwiftyJSON

class PhotoAlbum {

    var id: Int = 0
    var title: String = ""

    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
    }
}

enum PhotoAlbumTypeSystem {
    // case album_wall = -7
    // case album_profile = -6
    case album_wall
    case album_profile
    case album_saved
}
