//
//  UserFactory.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 15.02.2021.
//

import UIKit

class UsersData {
    var friends = [
        Friend(name: "Harlen Turner", avatar: UIImage(named: "face1")!),
        Friend(name: "Rhianne Hester", avatar: UIImage(named: "face2")!),
        Friend(name: "Blaine Benson", avatar: UIImage(named: "face3")!),
        Friend(name: "Charlotte Hope", avatar: UIImage(named: "face4")!),
        Friend(name: "Rajan Brady", avatar: UIImage(named: "face4")!),
        Friend(name: "Mccauley Roth", avatar: UIImage(named: "face4")!),
        Friend(name: "Nafeesa Childs", avatar: UIImage(named: "face4")!),
        Friend(name: "Kaylee Humphries", avatar: UIImage(named: "face4")!),
        Friend(name: "Carl Sheridan", avatar: UIImage(named: "face4")!),
        Friend(name: "Benito Dougherty", avatar: UIImage(named: "face4")!),
        Friend(name: "Om Odling", avatar: UIImage(named: "face4")!),
        Friend(name: "Mohamad Pike", avatar: UIImage(named: "face4")!)
].sorted { $0.name ?? "" < $1.name ?? "" }
}
