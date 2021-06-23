//
//  LikesTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.05.2021.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var reportsCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none

        // Configure the view for the selected state
    }

    func configure(with post: NewsFeedPost) {
        self.likesCount.text = String(post.likes)
        self.commentsCount.text = String(post.comments)
        self.reportsCount.text = String(post.reposts)
        self.viewsCount.text = String(post.views)
    }

}
