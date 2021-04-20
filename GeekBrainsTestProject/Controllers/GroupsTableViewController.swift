//
//  GroupsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    var nonFilteredGroups: [Group] = []
    let realmManager = RealmManager.shared

    var filteredGroups: [Group] = []

    let searchController = UISearchController(searchResultsController: nil)
    let networkManager = NetworkManager.shared

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }

    let loadingView = DMLoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: navigationController)
        self.tableView.addSubview(calculatedLoadingView)
        self.title = "My Groups"

        if (realmManager.getResult(selectedType: Group.self) != nil){
            self.nonFilteredGroups = self.realmManager.getArray(selectedType: Group.self)
            self.tableView.reloadData()
            self.loadingView.removeLoadingView()
        } else {
            // обновим базу групп при первой загрузке контроллера но покажем данные уже из базы
            networkManager.getGroupsForCurrentUserViaAlamofire(completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(groups):
                    guard let realmManager = self?.realmManager else { return }
                    self?.loadingView.removeLoadingView()
                    self?.realmManager.createGroupsDB(groups: groups)
                    self?.nonFilteredGroups = realmManager.getArray(selectedType: Group.self).sorted { $0.name < $1.name }
                    self?.tableView.reloadData()
                    self?.loadingView.removeLoadingView()
                }
            })
        }
        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Groups"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isFiltering {
            return filteredGroups.count
        }
        return nonFilteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell

        if isFiltering {
            let group = filteredGroups[indexPath.row]
            groupCell.groupLabel.text = group.name
            let groupAvatarUrl = group.photoStringUrl
            networkManager.getData(from: groupAvatarUrl) {data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [] in
                    groupCell.groupAvatar.image = UIImage(data: data)
                }
            }
        } else {
            let group = nonFilteredGroups[indexPath.row]
            groupCell.groupLabel.text = group.name
            let groupAvatarUrl = group.photoStringUrl
            networkManager.getData(from: groupAvatarUrl) {data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [] in
                    groupCell.groupAvatar.image = UIImage(data: data)
                }
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nonFilteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredGroups =  nonFilteredGroups.filter {(group: Group) -> Bool in
            return (group.name.lowercased().contains(searchText.lowercased()) )
        }
        tableView.reloadData()
    }

    func groupDBIsEmpty() -> Bool {
        if realmManager.getResult(selectedType: Group.self) != nil {
            return false
        }
        return true
    }
}

extension GroupsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
