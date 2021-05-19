//
//  NewsFeedTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.02.2021.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    let vkService = VKService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        vkService.getNewsFeedTextPosts()
        //vkService.getNewsFeedPhotoPosts()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textPostCell", for: indexPath) as! TextNewsFeedTableViewCell
        cell.postAuthor.text = "David"
        cell.views.text = "22"
        cell.comments.text = "109"
        cell.likes.text = "20"
        cell.postAvatarImage.image = UIImage(named: "face1")
        cell.reposts.text = "20"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
