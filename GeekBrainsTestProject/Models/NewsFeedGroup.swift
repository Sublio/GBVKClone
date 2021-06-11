//
//  NewsFeedGroup.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 08.06.2021.
//

import Foundation
import SwiftyJSON
import UIKit
import RealmSwift

@objcMembers
class NewsFeedGroup: RealmSwift.Object {
    dynamic var name: String = ""
    dynamic var id: Int = 0
    dynamic var groupAvatar: String = ""

    var photoUrl: URL? { URL(string: groupAvatar) }

    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        self.name = json["screen_name"].string ?? ""
        self.groupAvatar = json["photo_50"].string ?? ""
        self.id = json["id"].int ?? 0
    }

    override static func primaryKey() -> String? {
        "id"
    }
}
