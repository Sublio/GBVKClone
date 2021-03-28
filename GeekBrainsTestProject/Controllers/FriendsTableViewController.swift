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

    var notFilteredFriends: [User] = []
    var filteredFriends: [User] = []
    var userNames: [String] {
        UsersData().friends.map {$0.name}
    }
    var sections = [Section]()

    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.notFilteredFriends = UsersData().friends
        let groupedDictionary = Dictionary(grouping: userNames, by: {String($0.prefix(1))})
        let keys = groupedDictionary.keys.sorted()
        sections = keys.map {Section(letter: $0, names: groupedDictionary[$0]!.sorted())}
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friend"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.tableView.reloadData()
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
            cell.roundedView.image = friend.avatar
        } else {
            let section = sections[indexPath.section]
            let userName = section.names[indexPath.row]
            cell.friendLabel.text = userName
            cell.roundedView.image = notFilteredFriends.filter {$0.name == userName}.first?.avatar
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = PhotosCollectionViewController(collectionViewLayout: collectionViewFlowLayout)
        navigationController?.pushViewController(collectionView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
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

    func filterContentForSearchText(_ searchText: String) {
        filteredFriends =  notFilteredFriends.filter {(friend: User) -> Bool in
            return friend.name.lowercased().contains(searchText.lowercased())
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
