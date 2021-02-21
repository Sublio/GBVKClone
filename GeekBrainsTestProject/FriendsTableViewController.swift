//
//  FriendsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var notFilteredFriends = UsersData().sortedFriendsByFirstName
    var filteredFriends = [User]()

    let searcBar = DMSearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        searcBar.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50)
        self.tableView.tableHeaderView = searcBar
        searcBar.delegate = self
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        setGradientToTableView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredFriends.isEmpty {
            return notFilteredFriends[section].count
        } else {
            return filteredFriends.count
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {

        if filteredFriends.isEmpty {
            return notFilteredFriends.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! FriendTableViewCell

        if filteredFriends.isEmpty {
            cell.friendLabel.text = notFilteredFriends[indexPath.section][indexPath.row].name
            cell.roundedView.image = notFilteredFriends[indexPath.section][indexPath.row].avatar
        } else {
            cell.friendLabel.text = filteredFriends[indexPath.row].name
            cell.roundedView.image = filteredFriends[indexPath.row].avatar
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToCollectionView", sender: self)
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
        if !filteredFriends.isEmpty {
            label.text = filteredFriends.first?.name[0]
        } else {
            label.text = notFilteredFriends[section].first?.name[0]
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
        let nonFilteredFriends = notFilteredFriends.joined()
        var firstNames = [String]()
        for friend in nonFilteredFriends {
            firstNames.append(String(friend.name.characterAtIndex(index: 0)!))
        }
        return firstNames.uniqueElementsFrom(array: firstNames)
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

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            notFilteredFriends = UsersData().sortedFriendsByFirstName
            tableView.reloadData()
            self.resignFirstResponder()
        }
        // Create flat array first
        let friends = Array(notFilteredFriends.joined())
        // Filter
        filteredFriends = friends.filter {
            $0.name.contains(searchText)
        }
        // Reload TV
        tableView.reloadData()
    }
}
