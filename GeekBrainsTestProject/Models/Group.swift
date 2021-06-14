//
//  Group.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import SwiftyJSON
import UIKit
import RealmSwift

struct GroupResponse: Codable, ObjectProvider {
    let response: GroupContainer

    func getRealmObjects() -> [Object] {
        return response.items
    }
}

struct GroupContainer: Codable {
    let items: [Group]
}

class Group: Object, Codable {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var pictureUrlString: String = ""

    required convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        pictureUrlString = try container.decode(String.self, forKey: .pictureUrlString)
    }

    required convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.pictureUrlString = json["photo_100"].stringValue
    }

    var pictureUrl: URL? { URL(string: pictureUrlString) }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name
        case pictureUrlString = "photo_200"
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
