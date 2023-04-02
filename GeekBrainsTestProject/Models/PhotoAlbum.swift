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
    var owner_id: Int = 0

    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.owner_id = json["owner_id"].intValue
    }
}
