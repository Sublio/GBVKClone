//
//  FriendsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friends = [
        User(name: "David", avatar: UIImage(named:"face1")!, groups: [Group(name: "Group1", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Adam", avatar: UIImage(named: "face2")!, groups: [Group(name: "Group2", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Mark", avatar: UIImage(named: "face3")!, groups: [Group(name: "Group3", groupAvatar: UIImage(systemName: "person.3")!)]),
        User(name: "Brian", avatar: UIImage(named: "face4")!, groups: [Group(name: "Group4", groupAvatar: UIImage(systemName: "person.3")!)]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FriendTableViewCell
        cell.friendLabel.text = friends[indexPath.row].name
        cell.roundedView.image = friends[indexPath.row].avatar

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToCollectionView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
