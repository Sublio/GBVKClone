//
//  ASCALbumController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 21.07.2021.
//

import AsyncDisplayKit
import UIKit


class ASCAlbumViewController: ASDKViewController<ASTableNode>, PhotosTableViewDelegateProtocol {
    func didPickUserFromTableView(user: Friend) {
        self.albumOwner = user
    }
    
    
    var albumOwner: Friend?
    
    var tableNode: ASTableNode{
        node
    }
    
    private var reuseIdentifier = "AlbumCell"
    private var albums: [PhotoAlbum] = []
    
    override init() {
        super.init(node: ASTableNode())
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        guard let friend = self.albumOwner else { return }
        self.loadAlbums(friend: friend)
    }
    
    func loadAlbums(friend: Friend){
        
        NetworkManager.shared.getPhotoAlbumsForUserId(user_id: friend.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(albums):
                    self?.albums = albums
                    self?.tableNode.reloadData()
                }
            }
        }
    }
}


extension ASCAlbumViewController: ASTableDelegate, ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return albums.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let data = albums[indexPath.section]
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            let vc = InlineAlbumPhotosViewController()
            vc.album = data
            vc.loadPhotosFromAlbum()
            return vc
            
        }, didLoad: nil)
        
        let size = CGSize(width: tableNode.bounds.size.width, height: tableNode.bounds.size.height/4)
        node.style.preferredSize = size
        
        return{
            return node
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return albums[section].title
    }
}
