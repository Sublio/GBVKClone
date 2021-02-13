//
//  User.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import Foundation
import UIKit

struct User {
    var name: String
    var avatar: UIImage
    var groups: [Group]
    
    init(name: String, avatar: UIImage, groups:[Group]) {
        self.name = name
        self.avatar = avatar
        self.groups = groups
    }
}
