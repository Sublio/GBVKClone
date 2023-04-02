//
//  GroupFilterOperations.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 02.04.2023.
//

import Foundation

class FilterGroupsOperation: Operation {
    var groupList: [Group] = []

    override func main() {
        groupList = groupList.filter { group in
            return group.name != "DELETED"
        }
    }
}
