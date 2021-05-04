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
        likedView.frame = CGRect(x: self.frame.maxX + 40, y: self.frame.maxY + 40, width: 20, height: 20)
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
