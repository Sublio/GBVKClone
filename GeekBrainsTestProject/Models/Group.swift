//
//  Group.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import Foundation

struct  Group {
    var name: String
    var usersCount: Int
    var creationDate: String
    
    init(name: String, usersCount: Int, creationDate: String) {
        self.name = name
        self.usersCount = usersCount
        self.creationDate = creationDate
    }
}
