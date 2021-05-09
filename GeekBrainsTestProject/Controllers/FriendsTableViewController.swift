//
//  FriendsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit
import RealmSwift

struct Section {
    let letter: String
    let names: [String]
}

class FriendsTableViewController: UITableViewController {

    private var notificationToken: NotificationToken?

    let realmManager = RealmManager.shared
    let networkManager = NetworkManager.shared

    var notFilteredFriends: [Friend] = []
    var filteredFriends: [Friend] = []
    var userNames: [String] {
        notFilteredFriends.map {($0.name )}
    }

    var signOutButton: UIBarButtonItem {
        let button = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOut))
        return button
    }

    var userIds: [Int] {
        notFilteredFriends.map {($0.id )}
    }
    var sections: [Section] {
        let groupedDictionary = Dictionary(grouping: userNames, by: {String($0.prefix(1))})
        let keys = groupedDictionary.keys.sorted()
        return keys.map {Section(letter: $0, names: groupedDictionary[$0]!.sorted())}
    }

    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }

    let loadingView = DMLoadingView()

    weak var delegate: PhotosTableViewDelegateProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        UserDefaults.standard.setValue(Session.shared.token, forKey: "token")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        navigationItem.leftBarButtonItem = signOutButton
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: navigationController)
        self.tableView.addSubview(calculatedLoadingView)

        // обновим базу групп при первой загрузке контроллера но покажем данные уже из базы

        if realmManager.getResult(selectedType: Friend.self) != nil {
            self.notFilteredFriends = self.realmManager.getArray(selectedType: Friend.self)
            self.tableView.reloadData()
            self.loadingView.removeLoadingView()
        } else {
            networkManager.getFriendsListViaAlamoFire(completion: { [weak self] result in
                    switch result {
                    case let .failure(error):
                        print(error)
                    case let .success(friends):
                        guard let realmManager = self?.realmManager else { return }
                        self?.loadingView.removeLoadingView()
                        let friendsWithoutDeleted = friends.filter {
                            !$0.name.isEmpty
                        }
                        self?.realmManager.createFriendsDB(friends: friendsWithoutDeleted) // создаем базу из того что прилетело от api
                        self?.notFilteredFriends = realmManager.getArray(selectedType: Friend.self) // тут же получаем эту базу и ставим ее как data soource
                        self?.tableView.reloadData()
                        self?.loadingView.removeLoadingView()
                    }
            })
        }
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friend"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.tableView.reloadData()

        guard let currentFriendsArray = self.realmManager.getObjects(selectedType: Friend.self) else { return }
        self.notificationToken = currentFriendsArray.observe({ (changes: RealmCollectionChange) in
            switch changes {
                case .initial:
                    self.tableView.reloadData()
            case  .update:
                    self.notFilteredFriends = self.realmManager.getArray(selectedType: Friend.self)
                    self.tableView.reloadData()
                    self.loadingView.removeLoadingView()

                case .error(let error):
                    print(error)
                }
        })
    }

    deinit {
        notificationToken?.invalidate()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        }
        return sections[section].names.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        isFiltering ? 1 : sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FriendTableViewCell
        if isFiltering {
            let friend = filteredFriends[indexPath.row]
            cell.friendLabel.text = friend.name
            let avatarUrl = filteredFriends.filter {$0.name == friend.name}.first?.friendAvatar ?? ""
            networkManager.getData(from: avatarUrl) {data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [] in
                    cell.roundedView.image = UIImage(data: data)
                    self.loadingView.removeLoadingView()
                }
            }
        } else {
            let section = sections[indexPath.section]
            let userName = section.names[indexPath.row]
            cell.friendLabel.text = userName
            let avatarUrl = notFilteredFriends.filter {$0.name == userName}.first?.friendAvatar ?? ""
            networkManager.getData(from: avatarUrl) {data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [] in
                    cell.roundedView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 2
        collectionViewFlowLayout.minimumInteritemSpacing = 2
        let collectionView = PhotosCollectionViewController(collectionViewLayout: collectionViewFlowLayout)
        self.delegate = collectionView
        navigationController?.pushViewController(collectionView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        if isFiltering {
            let friend = filteredFriends[indexPath.row]
            self.delegate?.didPickUserFromTableWithId(userId: friend.id )
        } else {
            let section = sections[indexPath.section]
            let userName = section.names[indexPath.row]
            let clickedID = self.getUserIdByName(userName: userName)
            self.delegate?.didPickUserFromTableWithId(userId: clickedID ?? 0)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 30))
        view.backgroundColor = UIColor.blueZero.withAlphaComponent(0.5)
        let label = UILabel()
        label.frame = CGRect(x: 5, y: 5, width: Int(view.frame.width)-10, height: Int(view.frame.height) - 10)
        if isFiltering {
            label.text = ""
        } else {
            label.text = sections[section].letter
        }
        view.addSubview(label)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map {$0.letter}
    }

    func getUserIdByName(userName: String) -> Int? {
        var dict = [String: Int]()

        for (name, id) in zip(self.userNames, self.userIds) {
            dict[name] = id
        }
        return dict[userName]
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredFriends =  notFilteredFriends.filter {(friend: Friend) -> Bool in
            return (friend.name.lowercased().contains(searchText.lowercased()) )
        }
        tableView.reloadData()
    }

    @objc func signOut() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        UserDefaults.standard.setValue("", forKey: "token")
        
    }
}

extension FriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
