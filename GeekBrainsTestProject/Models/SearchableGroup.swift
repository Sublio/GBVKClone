//
//  SearchableGroup.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.04.2021.
//

import SwiftyJSON
import UIKit
import RealmSwift

@objcMembers
class  SearchableGroup: RealmSwift.Object {
    dynamic var name: String = ""
    dynamic var photoStringUrl: String = ""
    dynamic var id: Int = 0
    
    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        self.name = json["name"].string ?? ""
        self.photoStringUrl = json["photo_50"].string ?? ""
        self.id = json["id"].int ?? 0
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
