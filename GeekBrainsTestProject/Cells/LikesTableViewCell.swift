//
//  LikesTableViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.05.2021.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var likesCount: UILabel!{
        didSet {
            self.likesCount.backgroundColor = .white
        }
    }
    @IBOutlet weak var commentsCount: UILabel! {
        didSet {
            self.commentsCount.backgroundColor = .white
        }
    }
    @IBOutlet weak var reportsCount: UILabel! {
        didSet {
            self.reportsCount.backgroundColor = .white
        }
    }
    @IBOutlet weak var viewsCount: UILabel! {
        didSet {
            self.viewsCount.backgroundColor = .white
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

}
