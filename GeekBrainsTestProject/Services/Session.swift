//
//  Session.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 18.03.2021.
//

import Foundation

class Session {
    static let shared = Session()

    private init () {}

    var token: String = ""
    var userId: Int = 0
}
