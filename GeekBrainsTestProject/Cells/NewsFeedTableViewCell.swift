//
//  NewsFeedTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.02.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var picture: UIImageView!

    let likedView: LikedCustomView = {
       let view = LikedCustomView(frame: CGRect(x: 250, y: 360, width: 20, height: 20))
       return view
    }()

    override func layoutSubviews() {
        self.addSubview(likedView)
    }

}
