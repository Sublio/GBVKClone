//
//  GroupsTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 30.01.2021.
//

import UIKit
import RealmSwift
import Foundation
import Kingfisher

class GroupsTableViewController: UITableViewController {

    private lazy var groups: Results<Group>? = {
        return try? Realm().objects(Group.self).sorted(byKeyPath: "name", ascending: true)
    }()

    private var notificationToken: NotificationToken?

    let networkManager = NetworkManager.shared

    var cacheManager: CacheManager?

    let loadingView = DMLoadingView()

    let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        queue.name = "com.groups.parsing"
        queue.qualityOfService = .userInitiated
        return queue
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let cacheManager = CacheManager(container: self.tableView)
        self.cacheManager = cacheManager

        let parameters = [
            "access_token": Session.shared.token,
            "extended": "true",
            "v": networkManager.vkApiVersion
        ]
        guard let url = URL(string: "https://api.vk.com/method/groups.get") else { return }
        let downLoadOperation = LoadDataOperation(url: url, method: .get, params: parameters)
        let parsingOperation = ParsingOperation<GroupResponse>()
        parsingOperation.addDependency(downLoadOperation)

        let filterGroupsOperation = FilterGroupsOperation()
        filterGroupsOperation.addDependency(parsingOperation)

        let realmSavingOperation = RealmSavingOperation<GroupResponse>()
        realmSavingOperation.addDependency(parsingOperation)

        operationQueue.addOperations([downLoadOperation, parsingOperation, filterGroupsOperation, realmSavingOperation], waitUntilFinished: false)
        operationQueue.addBarrierBlock {
            DispatchQueue.main.async {
                self.loadingView.removeLoadingView()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        let calculatedLoadingView = loadingView.setLoadingScreen(for: self.tableView, navigationController: navigationController)
        self.tableView.addSubview(calculatedLoadingView)
        self.title = "My Groups"

        tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCellId")
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView

        notificationToken = groups?.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCell(withIdentifier: "groupCellId", for: indexPath) as! GroupTableViewCell

        let group = groups?[indexPath.row]
        groupCell.groupLabel.text = group?.name
        if let url = group?.pictureUrlString {
            groupCell.groupAvatar.image = self.cacheManager?.photo(at: indexPath, byUrl: url)
        }
        groupCell.selectionStyle = .none
        return groupCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
