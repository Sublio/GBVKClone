//
//  NewsFeedTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.02.2021.
//

import UIKit

class NewsFeedTableViewController: UITableViewController, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetch batches")
    }

    let vkService = VKService.shared

    private let textFont = UIFont.systemFont(ofSize: 14)

    private var openedTextCells: [IndexPath: Bool] = [:]

    private var posts: [NewsFeedPost] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    private var feedNextFromAnchor: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        let gradientView = GradientView()
        self.tableView.backgroundView = gradientView
        updateUI()
        self.refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .blueZero
        refreshControl?.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)

        tableView.prefetchDataSource = self
    }

    private func updateUI() {
        vkService.getNewsFeedTextPosts { postObjects, nextFromAnchor in
            self.posts = postObjects
            self.feedNextFromAnchor = nextFromAnchor
        }
    }

    @objc func refreshControlPulled() {
        print("pull to refresh")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.posts[indexPath.section]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! NewsHeaderTableViewCell
            cell.configure(with: post)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textPostCell") as! TextPostTableViewCell
            cell.configure(with: post)
            return cell

        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell") as! NewsFeedPictureTableViewCell
            cell.configure(with: post)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell") as! LikesTableViewCell
            cell.configure(with: post)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 3:
            return 60
        case 1:
            let maximumCellHeight: CGFloat = 100
            let text = posts[indexPath.section].text
            guard !text.isEmpty else { return 0 }
            let availableWidth = tableView.frame.width - 2 * TextPostTableViewCell.horizontalInset
            let desiredLabelHeight = self.getLabelSize(text: text, font: textFont, availableWidth: availableWidth).height + 2 * TextPostTableViewCell.verticalInset

            let isOpened = openedTextCells[indexPath] ?? false
            return isOpened ? desiredLabelHeight : min(maximumCellHeight, desiredLabelHeight)
        case 2:
            let aspectRatio = posts[indexPath.section].aspectRatio
            return tableView.frame.width * aspectRatio
        default:
            return UITableView.automaticDimension
        }
    }

    func getLabelSize(text: String, font: UIFont, availableWidth: CGFloat) -> CGSize {
        let textBlock = CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
}
