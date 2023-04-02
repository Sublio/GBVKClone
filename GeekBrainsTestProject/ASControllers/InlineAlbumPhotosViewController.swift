//
//  InlineAlbumPhotosViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 22.07.2021.
//

import AsyncDisplayKit


class InlineAlbumPhotosViewController: ASDKViewController<ASCollectionNode> {
    
    var album: PhotoAlbum?
    
    private var images:[Photo] = []
    private var collectionNode: ASCollectionNode
    
    
    override init() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.height/4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(node: collectionNode)
        collectionNode.dataSource = self
        collectionNode.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = album?.title
    }
    
    func loadPhotosFromAlbum(){
        
        guard let album = self.album else { return }
        NetworkManager.shared.getPhotosFrom(albumID: String(album.id), ownerID: String(album.owner_id)) { (result) in
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let photos):
                    self.images = photos
                    self.collectionNode.reloadData()
            }
        }
    }
}


extension InlineAlbumPhotosViewController: ASCollectionDataSource, ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("Hello")
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let image = images[indexPath.row]
        let photoCell = PhotoCellNode(with: URL(string: image.sizes.last!.url)!)
        return {
            return photoCell
        }
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
}
