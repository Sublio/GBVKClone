//
//  PhotosCollectionViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 31.01.2021.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController, PhotosTableViewDelegateProtocol {

    let realmManager = RealmManager.shared
    let networkManager = NetworkManager.shared
    var photos: [Photo] = []
    var realPhotos: [UIImage] = [] // This collection is for passing over to PhotoCommentViewController

    private let itemsPerRow: CGFloat = 3
    private let reuseIdentifier = "CollectionCell"

    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)

    private var selectedUserId: Int?

    let activityView = UIActivityIndicatorView(style: .large)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fadeView: UIView = UIView()
        fadeView.frame = self.collectionView.frame
        fadeView.backgroundColor = .white
        fadeView.alpha = 0.4
        self.view.addSubview(fadeView)
        self.view.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        activityView.startAnimating()

        guard let selectedUser = selectedUserId else { return }
        realmManager.delete(selectedType: Photo.self) // Удаляем предыдущие фотки от предыдущего пользователя
        networkManager.getPhotosForUserId(user_id: selectedUser, completion: {[weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(photos):
                    // self?.photos = photos
                    photos.forEach {
                        if let pictureData = self?.networkManager.getDataFrom(photoURl: $0.photoStringUrlMedium) {
                            $0.picture = pictureData
                        }
                    }
                    self?.realmManager.createPhotosDB(photos: photos)
                    self?.photos = (self?.realmManager.getArray(selectedType: Photo.self))!
                    self?.collectionView.reloadData()
                    self?.collectionView.alpha = 1
                    fadeView.removeFromSuperview()
                    self?.activityView.stopAnimating()
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
        self.edgesForExtendedLayout = []
    }

    deinit {
        realmManager.delete(selectedType: Photo.self) // Clean DB on every deinit
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ManagePageViewController") as! ManagePageViewController
        vc.photos = self.realPhotos
        vc.currentIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendPhotoCollectionViewCell

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        let photo = photos[indexPath.row]
        if let photo = UIImage(data: photo.picture) {
            cell.photo.image = photo
            self.realPhotos.append(photo)
        }
        cell.spinner.stopAnimating()
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
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
      }

    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
      }
}
