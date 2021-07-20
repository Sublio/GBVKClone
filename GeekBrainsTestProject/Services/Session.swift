//
//  Session.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 18.03.2021.
//

import Foundation

class Session {
    static let shared = Session()

    let networkManager = NetworkManager.shared

    private init () {}

    var token: String = ""

    func setTokenSessionFromKeychains() {
        if let token = KeychainService.loadToken(service: "tokenStorage") {
            self.token = token
        }
    }
}
