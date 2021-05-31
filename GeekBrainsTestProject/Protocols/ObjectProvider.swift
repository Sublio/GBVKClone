//
//  ObjectProvider.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 24.05.2021.
//

import Foundation
import RealmSwift

protocol ObjectProvider {
    func getRealmObjects() -> [Object]
}
