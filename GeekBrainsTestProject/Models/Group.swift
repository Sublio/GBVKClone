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
    @objc dynamic var groupId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var pictureUrlString: String = ""
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decode(Int.self, forKey: .groupId)
        name = try container.decode(String.self, forKey: .name)
        pictureUrlString = try container.decode(String.self, forKey: .pictureUrlString)
    }
    
    var pictureUrl: URL? { URL(string: pictureUrlString) }
    
    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case name
        case pictureUrlString = "photo_200"
    }
    
    override class func primaryKey() -> String? {
        return "groupId"
    }
}
