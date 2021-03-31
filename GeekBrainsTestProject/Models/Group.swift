//
//  Group.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import SwiftyJSON
import UIKit

struct  Group {
    var name: String?
    var groupAvatar: UIImage?
    let photoStringUrl: String

    init(name: String, groupAvatar: UIImage, photoStringUrl: String = "") {
        self.name = name
        self.groupAvatar = groupAvatar
        self.photoStringUrl = photoStringUrl
    } // this init is for object stubs only.It is used by default with init via json

    init(json: SwiftyJSON.JSON) {
        self.name = json["name"].string ?? ""
        self.photoStringUrl = json["photo_50"].string ?? ""
    }
}
