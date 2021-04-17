//
//  GroupSearchTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 01.02.2021.
// realmManager.getArray(selectedType: SearchableGroup.self).sorted { $0.name < $1.name }

import UIKit

class GroupSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    let realmManager = RealmManager.shared

    var foundGroups: [SearchableGroup] = []
    let searchController = UISearchController(searchResultsController: nil)
    let networkManager = NetworkManager.shared
    let loadingView = DMLoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Group"
        searchController.searchBar.delegate = self
        searchController.isActive = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.tableView.reloadData()
    }

    deinit {
        realmManager.delete(selectedType: SearchableGroup.self) // clean up previous search
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
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: self.navigationController!)
        self.tableView.addSubview(calculatedLoadingView)
        let group = foundGroups[indexPath.row]
        groupCell.groupLabel.text = group.name
        let groupAvatarUrl = group.photoStringUrl
        networkManager.getData(from: groupAvatarUrl) {data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [] in
                self.loadingView.removeLoadingView()
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
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: self.navigationController!)
        self.tableView.addSubview(calculatedLoadingView)
        guard let searchQuery = searchController.searchBar.text else { return }
        if !searchQuery.isEmpty {

            // Мы сперва делаем запрос в VK api - затем сохраним в Realm - а потом уже покажем данные из Realm
            networkManager.getGroupsBySearchString(searchString: searchQuery, completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(groups):
                    self?.realmManager.delete(selectedType: SearchableGroup.self) // очищаем все перед новым поиском
                    self?.tableView.reloadData()
                    self?.realmManager.createSearchableGroupsDB(groups: groups) // ставим вновь найденные данные из базы
                    self?.foundGroups = self!.realmManager.getArray(selectedType: SearchableGroup.self)
                    self?.tableView.reloadData()
                    self?.loadingView.removeLoadingView()
                }
            })
        } else {
            self.realmManager.delete(selectedType: SearchableGroup.self)
            self.foundGroups = []
            self.tableView.reloadData()
            self.loadingView.removeLoadingView()
        }
    }
}

extension GroupSearchTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.foundGroups = []
        self.realmManager.delete(selectedType: SearchableGroup.self)
        self.tableView.reloadData()
    }
}
