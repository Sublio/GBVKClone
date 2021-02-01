//
//  GroupsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var currentGroups = [
        Group(name: "Group1", groupAvatar: UIImage(systemName: "pencil.tip")!),
        Group(name: "Group2", groupAvatar: UIImage(systemName: "pencil.circle")!),
        Group(name: "Group3", groupAvatar: UIImage(systemName: "lasso")!),
        Group(name: "Group4", groupAvatar: UIImage(systemName: "folder")!)
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell
        groupCell.groupLabel.text = currentGroups[indexPath.row].name
        groupCell.groupAvatar.image = currentGroups[indexPath.row].groupAvatar

        return groupCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
