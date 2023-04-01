//
//  GroupTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupAvatar: RoundedView!
    @IBOutlet weak var groupLabel: UILabel! {
        didSet {
            self.groupLabel.backgroundColor = .clear
        }
    }
    private let avatarWidth: CGFloat = 30
    private let avatarHeight: CGFloat = 30
    private let offset: CGFloat = 12

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let zeroYPointAvatar: CGFloat = (contentView.bounds.height/2) - avatarHeight / 2
        let zeroXPointAvatar: CGFloat = offset
        groupAvatar.frame = CGRect(x: zeroXPointAvatar, y: zeroYPointAvatar, width: avatarWidth, height: avatarHeight)
        groupLabel.frame = CGRect(origin:
                                    CGPoint(
                                        x: groupAvatar.frame.maxX + offset,
                                        y: (contentView.bounds.height/2) - avatarHeight / 3),
                                   size: groupLabel.intrinsicContentSize)
    }
}
