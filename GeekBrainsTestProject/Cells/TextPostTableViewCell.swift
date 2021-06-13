//
//  TextPostTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.05.2021.
//

import UIKit

class TextPostTableViewCell: UITableViewCell {

    static let horizontalInset: CGFloat = 12
    static let verticalInset: CGFloat = 8

    @IBOutlet weak var textPost: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with post: NewsFeedPost) {
        self.textPost.text = post.text
    }

}
