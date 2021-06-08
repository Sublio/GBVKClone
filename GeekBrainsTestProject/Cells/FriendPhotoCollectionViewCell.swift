//
//  FriendPhotoCollectionViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {

    lazy var spinner = UIActivityIndicatorView(style: .medium)
    @IBOutlet weak var photo: UIImageView!

    let likedView: LikedCustomView = {
        let view = LikedCustomView()
        return view
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.photo.frame = CGRect(x: (contentView.bounds.minX).rounded(), y: (contentView.bounds.minY).rounded(), width: (contentView.frame.width).rounded(), height: (contentView.frame.height).rounded())
        likedView.frame = CGRect(x: contentView.bounds.maxX-40, y: contentView.bounds.maxY-40, width: 40, height: 10)
        self.contentView.addSubview(likedView)
        self.photo.frame = CGRect(x: (contentView.bounds.minX).rounded(), y: (contentView.bounds.minY).rounded(), width: (contentView.frame.width).rounded(), height: (contentView.frame.height).rounded())
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.photo.contentMode = .scaleAspectFill
    }

    private func commonInit() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
