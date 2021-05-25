//
//  Photo.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Photo: RealmSwift.Object {
    
    dynamic var photoStringUrlMedium: String = ""
    dynamic var photoId: String = UUID().uuidString
    dynamic var picture: Data = Data()
    
    let friends = LinkingObjects(fromType: Friend.self, property: "friendPhotos")
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.photoStringUrlMedium = json["url"].string ?? ""
    }
    
    override static func primaryKey() -> String? {
        "photoId"
    }
}
