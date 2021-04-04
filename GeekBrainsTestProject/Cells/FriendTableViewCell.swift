//
//  FriendTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var friendLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
