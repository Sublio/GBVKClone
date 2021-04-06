//
//  User.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import SwiftyJSON
import UIKit
import RealmSwift

class Friend: RealmSwift.Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photoString: String = ""

//    init(name: String, avatar: UIImage) {
//        self.name = name
//        self.avatar = avatar
//        self.photoString = ""
//    } // this init is for object stubs only.

//    init(json: SwiftyJSON.JSON) {
//        let firstName = json["first_name"].string ?? ""
//        let lastName = json["last_name"].string ?? ""
//        self.name = firstName + " " + lastName
//        self.photoString = json["photo_50"].string ?? ""
//        self.id = json["id"].int ?? 0
//    }

    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        let firstName = json["first_name"].string ?? ""
        let lastName = json["last_name"].string ?? ""
        self.name = firstName + " " + lastName
        self.photoString = json["photo_50"].string ?? ""
        self.id = json["id"].int ?? 0
    }
}
