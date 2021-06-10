//
//  TextPostTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.05.2021.
//

import UIKit

class TextPostTableViewCell: UITableViewCell {

    @IBOutlet weak var textPost: UITextView! {
        didSet {
            self.textPost.backgroundColor = .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with post: NewsFeedPost) {
        self.textPost.text = post.text
    }

}
