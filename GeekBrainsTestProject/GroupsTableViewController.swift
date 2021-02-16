//
//  GroupsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    let searchBar = DMSearchBar()

    var nonFilteredGroups = GroupFactory().defaultGroups

    var filteredGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))

        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
        setGradientToTableView()
        searchBar.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50)
        self.tableView.tableHeaderView = searchBar
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if filteredGroups.isEmpty {
            return nonFilteredGroups.count
        } else {
            return filteredGroups.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell

        if filteredGroups.isEmpty {
            groupCell.groupLabel.text = nonFilteredGroups[indexPath.row].name
            groupCell.groupAvatar.image = nonFilteredGroups[indexPath.row].groupAvatar
        } else {
            groupCell.groupLabel.text = filteredGroups[indexPath.row].name
            groupCell.groupAvatar.image = filteredGroups[indexPath.row].groupAvatar
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

    @objc func handleAdd() {
        let newGroup = Group(name: "Just created Group", groupAvatar: UIImage(systemName: "folder")!)
        nonFilteredGroups.append(newGroup)
        self.tableView.reloadData()
    }

    func setGradientToTableView() {
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
        gradientLayer.frame = self.tableView.bounds
        let keeperView = UIView(frame: self.tableView.bounds)
        keeperView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = keeperView
    }
}

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0 {
            nonFilteredGroups = GroupFactory().defaultGroups
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }

        filteredGroups = nonFilteredGroups.filter {
            $0.name.contains(searchText)
        }

        tableView.reloadData()

    }
}
