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

        // Configure the view for the selected state
    }

}
