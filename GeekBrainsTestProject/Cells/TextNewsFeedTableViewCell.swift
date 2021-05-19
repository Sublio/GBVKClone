//
//  NewsFeedTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.02.2021.
//

import UIKit

class TextNewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var postAuthor: UILabel!
    @IBOutlet weak var postAvatarImage: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var reposts: UILabel!
    @IBOutlet weak var views: UILabel!

}
