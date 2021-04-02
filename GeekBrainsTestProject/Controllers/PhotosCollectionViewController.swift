//
//  PhotosCollectionViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController, PhotosTableViewDelegateProtocol {

    let networkManager = NetworkManager()
    let imageDownloader = ImageDownloaderService()
    var photos: [Photo] = []

    private let itemsPerRow = 4
    private let reuseIdentifier = "CollectionCell"

    private let sectionInsets = UIEdgeInsets(
      top: 40.0,
      left: 20.0,
      bottom: 20.0,
      right: 20.0)

    private var selectedUserId: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedUser = selectedUserId else { return }
        networkManager.getPhotosForUserId(user_id: selectedUser, completion: {[weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(photos):
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "FriendPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.isPagingEnabled = true
        self.view.isUserInteractionEnabled = true
        self.title = "Photos"
        let gradientView = GradientView()
        self.collectionView.backgroundView = gradientView
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenImageVC = FullScreenPhotoViewController()
        fullScreenImageVC.selectedImageIndex = indexPath.row
        self.present(fullScreenImageVC, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotoCollectionViewCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        let photo = photos[indexPath.row]
        imageDownloader.getData(from: photo.photoStringUrlMedium) {data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                cell.photo.image = UIImage(data: data)
            }
        }

        return cell
    }

    // Delegate function from FriendsController
    func didPickUserFromTableWithId(userId: Int) {
        self.selectedUserId = userId
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        let paddingSpace = Int(sectionInsets.left) * (itemsPerRow + 1)
        let availableWidth = view.frame.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)

        return CGSize(width: widthPerItem, height: widthPerItem)
      }

    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
      }
}
