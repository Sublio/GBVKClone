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
        updateUI()
    }

    private func updateUI() {

        vkService.getNewsFeedTextPosts(returnCompletion: { result in
            DispatchQueue.main.async {
                print(result)
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! NewsHeaderTableViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textPostCell") as! TextPostTableViewCell
            return cell

        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell") as! NewsFeedPictureTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell") as! LikesTableViewCell
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let indexPathRange = 1...2

        if indexPathRange.contains(indexPath.row) {
            return 180
        } else {
            return 40
        }
    }
}
