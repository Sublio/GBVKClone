//
//  FriendTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit
import Kingfisher

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var friendLabel: UILabel! {
        didSet {
            friendLabel.backgroundColor = .clear
        }
    }

    private let avatarWidth: CGFloat = 30
    private let avatarHeight: CGFloat = 30
    private let offset: CGFloat = 12

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let zeroYPointAvatar: CGFloat = (contentView.bounds.height/2) - avatarHeight / 2
        let zeroXPointAvatar: CGFloat = offset
        roundedView.frame = CGRect(x: zeroXPointAvatar, y: zeroYPointAvatar, width: avatarWidth, height: avatarHeight)
        friendLabel.frame = CGRect(origin:
                                    CGPoint(
                                        x: roundedView.frame.maxX + offset,
                                        y: (contentView.bounds.height/2) - avatarHeight / 3),
                                   size: friendLabel.intrinsicContentSize)
    }

    public func configure(with friend: Friend) {
        friendLabel.text = friend.name
    }
}
