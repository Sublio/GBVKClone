//
//  NewsFeedProfile.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 22.05.2021.
//

import SwiftyJSON

class NewsFeedProfile {
    var firstName: String = ""
    var lastName: String  = ""
    var photoUrl: String  = ""

    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        self.firstName = json["first_name"].string ?? ""
        self.lastName = json["last_name"].string ?? ""
        self.photoUrl = json["photo_100"].string ?? ""
    }
}
