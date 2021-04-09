//
//  GroupSearchTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
//

import UIKit

class GroupSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var foundGroups: [Group] = []
    let searchController = UISearchController(searchResultsController: nil)
    let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friend"
        searchController.searchBar.delegate = self
        searchController.isActive = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell
        let group = foundGroups[indexPath.row]
        groupCell.groupLabel.text = group.name
        let groupAvatarUrl = group.photoStringUrl
        networkManager.getData(from: groupAvatarUrl) {data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [] in
                groupCell.groupAvatar.image = UIImage(data: data)
            }
        }
        return groupCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else { return }
        if !searchQuery.isEmpty {
            networkManager.getGroupsBySearchString(searchString: searchQuery, completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(groups):
                    self?.foundGroups = groups
                    self?.tableView.reloadData()
                }
            })
        }
    }
}

extension GroupSearchTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.foundGroups = []
        self.tableView.reloadData()
    }
}
