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
    
    let roundedCornersView = CustomBottomRoundedView()
    
    
    let separatorView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
            return view
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSeparatorView()
        setupRoundedCornersView()
        
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSeparatorView()
        setupRoundedCornersView()
    }
    
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
    
    
    private func setupSeparatorView() {
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    private func setupRoundedCornersView(){
        roundedCornersView.translatesAutoresizingMaskIntoConstraints = false
        roundedCornersView.backgroundColor = .clear
        addSubview(roundedCornersView)
        NSLayoutConstraint.activate([
                   roundedCornersView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   roundedCornersView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                   roundedCornersView.topAnchor.constraint(equalTo: contentView.topAnchor),
                   roundedCornersView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
