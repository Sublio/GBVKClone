//
//  FriendPhotoCollectionViewCell.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {

    let likedView: LikedCustomView = {
       let view = LikedCustomView(frame: CGRect(x: 70, y: 75, width: 20, height: 20))
       return view
    }()

    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(likedView)
    }

}
