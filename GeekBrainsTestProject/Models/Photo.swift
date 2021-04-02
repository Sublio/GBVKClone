//
//  Photo.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import SwiftyJSON

struct Photo {
    // let photoStringUrlSmall: String
    // let photoStringUrlX: String
    let photoStringUrlMedium: String

    init(json: SwiftyJSON.JSON) {
        self.photoStringUrlMedium = json["url"].string ?? ""
    }
}
