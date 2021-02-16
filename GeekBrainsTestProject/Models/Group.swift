//
//  Group.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import Foundation
import UIKit

struct  Group {
    var name: String
    var groupAvatar: UIImage

    init(name: String, groupAvatar: UIImage) {
        self.name = name
        self.groupAvatar = groupAvatar
    }
}
