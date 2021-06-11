//
//  NewsFeedPost.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import SwiftyJSON
import Foundation
import CoreGraphics

class NewsFeedPost {
    var date: Date
    var type: String
    var postId: Int = 0
    var comments: Int = 0
    var likes: Int = 0
    var reposts: Int = 0
    var views: Int = 0
    var text: String = ""
    var postPhotoURL = ""
    var photoWidth = 0
    var photoHeight = 0

    var aspectRatio: CGFloat {
        guard photoWidth != 0 else { return 0 }
        return CGFloat(photoHeight) / CGFloat(photoWidth)
    }

    init (json: SwiftyJSON.JSON) {
        self.date = Date(timeIntervalSince1970: TimeInterval(json["date"].doubleValue))
        self.type = json["type"].stringValue
        self.postId = json["post_id"].int ?? 0
        self.comments = json["views"]["count"].int ?? 0
        self.likes = json["likes"]["count"].int ?? 0
        self.reposts = json["reposts"]["count"].int ?? 0
        self.views = json["views"]["count"].int ?? 0
        self.text = json["text"].string ?? ""

        if type == "post"{
            let attach = json["attachments"][0]
            switch attach["type"] {
            case "photo":
                let photoSizes = attach["photo"]["sizes"].arrayValue
                guard let photoSizeX = photoSizes.last else { print("Error"); return}
                self.postPhotoURL = photoSizeX["url"].stringValue
                self.photoWidth = photoSizeX["width"].intValue
                self.photoHeight = photoSizeX["height"].intValue
            default:
                self.postPhotoURL = ""
            }
        }
    }
}
