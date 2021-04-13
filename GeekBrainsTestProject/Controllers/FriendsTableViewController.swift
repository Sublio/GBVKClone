//
//  FriendsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

struct Section {
    let letter: String
    let names: [String]
}

class FriendsTableViewController: UITableViewController {

    var notFilteredFriends: [Friend] = []
    var filteredFriends: [Friend] = []
    var userNames: [String] {
        notFilteredFriends.map {($0.name )}
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
    let networkManager = NetworkManager.shared

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }

    let loadingView = DMLoadingView()

    weak var delegate: PhotosTableViewDelegateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: self.navigationController!)
        self.tableView.addSubview(calculatedLoadingView)

        networkManager.getFriendsListViaAlamoFire(completion: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                self?.loadingView.removeLoadingView()
                self?.notFilteredFriends = friends
                self?.tableView.reloadData()
            }
        })
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friend"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        }
        return sections[section].names.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        if isFiltering {
            return 1
        } else {
            return sections.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FriendTableViewCell
        if isFiltering {
            let friend = filteredFriends[indexPath.row]
            cell.friendLabel.text = friend.name
            let avatarUrl = filteredFriends.filter {$0.name == friend.name}.first?.photoString ?? ""
            networkManager.getData(from: avatarUrl) {data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [] in
                    cell.roundedView.image = UIImage(data: data)
                }
            }
        } else {
            let section = sections[indexPath.section]
            let userName = section.names[indexPath.row]
            cell.friendLabel.text = userName
            let avatarUrl = notFilteredFriends.filter {$0.name == userName}.first?.photoString ?? ""
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
}

extension FriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
