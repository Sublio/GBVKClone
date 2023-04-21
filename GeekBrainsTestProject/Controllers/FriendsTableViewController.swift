//
//  FriendsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit
import RealmSwift
import PromiseKit

class FriendsTableViewController: UITableViewController {

    private var notificationToken: NotificationToken?

    let realmManager = RealmManager.shared
    let networkManager = NetworkManager.shared
    var cacheManager: CacheManager?

    var filteredFriends: Results<Friend>? =  RealmManager.shared.getObjects(selectedType: Friend.self)?.sorted(byKeyPath: "name", ascending: true)
    var signOutButton: UIBarButtonItem {
        let button = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOut))
        return button
    }

    weak var delegate: PhotosTableViewDelegateProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cacheManager = CacheManager(container: self.tableView)
        self.cacheManager = cacheManager
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        KeychainService.saveToken(service: "tokenStorage", data: Session.shared.token)
        networkManager.getFriendsListViaAlamoFire(completion: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):

                let filteredFriends = friends.filter { friend in
                    return friend.name.trimmingCharacters(in: .whitespaces) != "DELETED"
                }

                try? self.realmManager.save(items: filteredFriends, update: .modified)
                // Update the filteredFriends property and reload the tableView
                self.filteredFriends = self.realmManager.getObjects(selectedType: Friend.self)?.sorted(byKeyPath: "name", ascending: true)
                self.tableView.reloadData()
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = signOutButton
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        definesPresentationContext = true
        self.tableView.reloadData()
        notificationToken = filteredFriends?.observe {[weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends?.count ?? 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
        guard let friends = filteredFriends else { return UITableViewCell() }
        let friend = friends[indexPath.row]
        cell.configure(with: friend)
        cell.roundedView.image = self.cacheManager?.photo(at: indexPath, byUrl: friend.friendAvatar)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 2
        collectionViewFlowLayout.minimumInteritemSpacing = 2
        let collectionView = PhotosCollectionViewController(collectionViewLayout: collectionViewFlowLayout)
        collectionView.modalTransitionStyle = .crossDissolve
        collectionView.modalPresentationStyle = .overFullScreen
        self.delegate = collectionView
        navigationController?.pushViewController(collectionView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedFriend = filteredFriends?[indexPath.row] {
            self.delegate?.didPickUserFromTableView(user: selectedFriend)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
