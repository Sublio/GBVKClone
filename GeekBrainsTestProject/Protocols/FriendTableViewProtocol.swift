//
//  FriendTableViewProtocol.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.04.2021.
//

import Foundation
import UIKit

protocol PhotosTableViewDelegateProtocol: AnyObject {
    
   //func didPickUserFromTableWithId(userId: Int)
    func didPickUserFromTableView(user: Friend)
}
