//
//  NewsFeedPost.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import SwiftyJSON
import Foundation

class NewsFeedPost {
    var date: Date
    var type: String
    var postId: Int = 0
    var comments: Int = 0
    var likes: Int = 0
    var reposts: Int = 0
    var views: Int = 0
    var text: String = ""

    init (json: SwiftyJSON.JSON) {
        self.date = Date(timeIntervalSince1970: TimeInterval(json["date"].doubleValue))
        self.type = json["type"].stringValue
        self.postId = json["post_id"].int ?? 0
        self.comments = json["views"]["count"].int ?? 0
        self.likes = json["likes"]["count"].int ?? 0
        self.reposts = json["reposts"]["count"].int ?? 0
        self.views = json["views"]["count"].int ?? 0
        self.text = json["text"].string ?? ""
    }
}
