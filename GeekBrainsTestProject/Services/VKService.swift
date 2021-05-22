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
    
    func getNewsFeedTextPosts(returnCompletion:@escaping ((NewsFeedPostObject))->()){
        let dispatchGroup = DispatchGroup()
        
        DispatchQueue.global().async(group: dispatchGroup){
            self.networkManager.getNewsFeedPostViaAlamofire(count: 1,completion: { result in
                switch result {
                case let .failure(error):
                    print (error)
                case let .success(data):
                    guard let json = try? JSON(data: data) else { return }
                    let newsFeedJsonItems = json["response"]["items"].arrayValue
                    let newsFeedJsonProfiles = json["response"]["profiles"].arrayValue
                    let newsFeedJsonGroups = json["response"]["groups"].arrayValue
                    let parsedProfiles = newsFeedJsonProfiles.map { NewsFeedProfile(json: $0)}
                    let parsedGroups = newsFeedJsonGroups.map {Group(json: $0)}
                    let parsedPosts = newsFeedJsonItems.map { NewsFeedPost(json: $0) }
                    let obj = NewsFeedPostObject(posts: parsedPosts, groups: parsedGroups, profiles: parsedProfiles)
                    returnCompletion(obj)
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
