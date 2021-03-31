//
//  User.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import SwiftyJSON
import UIKit

struct Friend {
    var name: String?
    var avatar: UIImage?
    var groups: [Group]?
    let photoString: String

    init(name: String, avatar: UIImage, groups: [Group]) {
        self.name = name
        self.avatar = avatar
        self.groups = groups
        self.photoString = ""
    } // this init is for object stubs only.It is overriden by default with init via json

    init(json: SwiftyJSON.JSON) {
        let firstName = json["first_name"].string ?? ""
        let lastName = json["last_name"].string ?? ""
        self.name = firstName + " " + lastName
        self.photoString = json["photo_50"].string ?? ""
    }
}
