//
//  Photo.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: RealmSwift.Object {
    @objc dynamic var photoStringUrlMedium: String = ""

//    init(json: SwiftyJSON.JSON) {
//        self.photoStringUrlMedium = json["url"].string ?? ""
//    }

    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.photoStringUrlMedium = json["url"].string ?? ""
    }
}
