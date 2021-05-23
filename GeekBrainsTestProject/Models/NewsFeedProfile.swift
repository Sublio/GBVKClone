//
//  NewsFeedProfile.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 22.05.2021.
//

import SwiftyJSON
import RealmSwift
import Foundation

@objcMembers
class NewsFeedProfile: RealmSwift.Object {
    dynamic var profileId: String = UUID().uuidString
    dynamic var firstName: String = ""
    dynamic var lastName: String  = ""
    dynamic var photoUrl: String  = ""

    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        self.firstName = json["first_name"].string ?? ""
        self.lastName = json["last_name"].string ?? ""
        self.photoUrl = json["photo_100"].string ?? ""
    }
    
    override static func primaryKey() -> String? {
        "profileId"
    }
}
