//
//  FriendTableViewProtocol.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import UIKit

protocol PhotosTableViewDelegateProtocol: class {
    // func didPickUserFromTableWithId(userId: Int,with photos: [UIImage])
    func didPickUserFromTableWithId(userId: Int)
}
