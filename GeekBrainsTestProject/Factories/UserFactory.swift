//
//  UserFactory.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 15.02.2021.
//

import UIKit

class UsersData {
    var friends = [
        User(name: "Harlen Turner", avatar: UIImage(named: "face1")!, groups: [Group(name: "Group1", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Rhianne Hester", avatar: UIImage(named: "face2")!, groups: [Group(name: "Group2", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Blaine Benson", avatar: UIImage(named: "face3")!, groups: [Group(name: "Group3", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Charlotte Hope", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group4", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Rajan Brady", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Aydin Shannon", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Mccauley Roth", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Nafeesa Childs", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Kaylee Humphries", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Carl Sheridan", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Benito Dougherty", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Om Odling", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Mohamad Pike", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group5", groupAvatar: UIImage(systemName: "person.3")!)])
    ].sorted { $0.name < $1.name }
}
