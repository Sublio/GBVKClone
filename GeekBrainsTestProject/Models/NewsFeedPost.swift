//
//  NewsFeedPost.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import SwiftyJSON
import RealmSwift

@objcMembers
class NewsFeedPost: RealmSwift.Object {
    dynamic var postId: Int = 0
    dynamic var comments: Int = 0
    dynamic var likes: Int = 0
    dynamic var reposts: Int = 0
    dynamic var views: Int = 0
    dynamic var text: String = ""

    convenience init (json: SwiftyJSON.JSON) {
        self.init()
        self.postId = json["post_id"].int ?? 0
        self.comments = json["views"]["count"].int ?? 0
        self.likes = json["likes"]["count"].int ?? 0
        self.reposts = json["reposts"]["count"].int ?? 0
        self.views = json["views"]["count"].int ?? 0
        self.text = json["text"].string ?? ""
    }

    override static func primaryKey() -> String? {
        "postId"
    }
}
