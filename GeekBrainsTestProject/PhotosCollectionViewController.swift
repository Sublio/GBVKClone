//
//  PhotosCollectionViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

private let reuseIdentifier = "CollectionCell"

class PhotosCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "FriendPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        setGradientToCollectionViewView()
        self.view.isUserInteractionEnabled = true
        self.title = "Photos"
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenImageVC = FullScreenPhotoViewController()
        fullScreenImageVC.selectedImageIndex = indexPath.row
        // show(fullScreenImageVC, sender: nil)
        self.present(fullScreenImageVC, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotoCollectionViewCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor

        let resizedImage = UIImage(named: "face\(indexPath.row+1)")!.resized(to: CGSize(width: 100, height: 100))

        cell.photo.image = resizedImage

        return cell
    }

    func setGradientToCollectionViewView() {
        let hexColors: [CGColor] = [
            UIColor.blueZero.cgColor,
            UIColor.white.cgColor
        ]

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = hexColors
        gradientLayer.locations = [0.0, 0.5]
        // Vertical mode for gradient
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint   = .init(x: 0, y: 1)
        gradientLayer.frame = self.collectionView.bounds
        let keeperView = UIView(frame: self.collectionView.bounds)
        keeperView.layer.insertSublayer(gradientLayer, at: 0)
        self.collectionView.backgroundView = keeperView
    }

}
