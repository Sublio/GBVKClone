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
    var age: Int
    var avatar: UIImage?
    
    init(name: String, age: Int, avatar: UIImage?) {
        self.name = name
        self.age = age
        self.avatar = avatar
    }
}
