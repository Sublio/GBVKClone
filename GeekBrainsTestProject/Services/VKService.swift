//
//  VKService.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import Foundation
import SwiftyJSON
import Alamofire

class VKService {
    
    static let shared = VKService()
    let networkManager = NetworkManager.shared
    
    private init () {}
    
    typealias NextFromAnchor = String
    
    func getNewsFeedTextPosts(startTime: Date? = nil, nextFrom: String? = nil, _ completion: @escaping (NewsFeedPostObject, NextFromAnchor) -> Void) {
        let parsingGroup = DispatchGroup()
        
        let scheme = "https://"
        let host = networkManager.apiHost
        let path = "/method/newsfeed.get"
        var parameters: Parameters = [
            "access_token": Session.shared.token,
            "filters": "post",
            "count": 2,
            "v": networkManager.vkApiVersion
        ]
        if let startTime = startTime {
            parameters["start_time"] = String(startTime.timeIntervalSince1970 + 1)
        }
        if let nextFrom = nextFrom {
            parameters["start_from"] = nextFrom
        }
        
        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let data = data else { return }
                var posts: [NewsFeedPost] = []
                var profiles: [NewsFeedProfile] = []
                let json = JSON(data)
                let nextFromAnchor = json["response"]["next_from"].stringValue
                
                DispatchQueue.global().async(group: parsingGroup, qos: .userInitiated) {
                    guard let json = try? JSON(data:data) else { return }
                    let postJSONs = json["response"]["items"].arrayValue
                    posts = postJSONs.compactMap { NewsFeedPost(json: $0) }
                }
                
                DispatchQueue.global().async(group: parsingGroup, qos: .userInitiated) {
                    guard let json = try? JSON(data:data) else { return }
                    let newsFeedJsonProfiles = json["response"]["profiles"].arrayValue
                    profiles = newsFeedJsonProfiles.compactMap { NewsFeedProfile(json: $0) }
                }
                
                parsingGroup.notify(queue: .main){
                    let postObject = NewsFeedPostObject(posts: posts, profiles: profiles)
                    completion(postObject,nextFromAnchor )
                }
            }
        }
    }    
}
