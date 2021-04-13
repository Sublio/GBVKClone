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
       let view = LikedCustomView(frame: CGRect(x: 70, y: 75, width: 20, height: 20))
       return view
    }()

    override init(frame: CGRect) {
               super.init(frame: frame)
               commonInit()
           }

           required init?(coder: NSCoder) {
               super.init(coder: coder)
               commonInit()
           }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.photo.contentMode = .scaleAspectFill
        addSubview(likedView)
    }

    private func commonInit() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
