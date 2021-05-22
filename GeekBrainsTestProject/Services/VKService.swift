//
//  VKService.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import Foundation
import SwiftyJSON

class VKService {
    
    static let shared = VKService()
    let networkManager = NetworkManager.shared

    private init () {}
    
    func getNewsFeedTextPosts(returnCompletion:@escaping ([NewsFeedPost])->()){
        let dispatchGroup = DispatchGroup()
        
        DispatchQueue.global().async(group: dispatchGroup){
            self.networkManager.getNewsFeedPostViaAlamofire(count: 4,completion: { result in
                switch result {
                case let .failure(error):
                    print (error)
                case let .success(data):
                    guard let json = try? JSON(data: data) else { return }
                    let newsFeedJsonItems = json["response"]["items"].arrayValue
                    let parsedPosts = newsFeedJsonItems.map { NewsFeedPost(json: $0) }
                    returnCompletion(parsedPosts as [NewsFeedPost])
                    
                }
            })
        }
    }
            
    

    
    func getNewsFeedPhotoPosts(){
        networkManager.getNewsFeedPhotoPostViaAlamofire(count: 1,completion: { result in
            switch result {
            case let .failure(error):
                print (error)
            case let .success(posts):
                print(posts)
            }
        })
    }
}
