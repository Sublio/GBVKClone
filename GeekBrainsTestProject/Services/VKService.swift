//
//  VKService.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 19.05.2021.
//

import Foundation

class VKService {
    
    static let shared = VKService()
    let networkManager = NetworkManager.shared

    private init () {}
    
    func getNewsFeedTextPosts(){

        networkManager.getNewsFeedPostViaAlamofire(count: 2,completion: { result in
            switch result {
            case let .failure(error):
                print (error)
            case let .success(posts):
                print(posts)
            }
        })
    }
    
    func getNewsFeedPhotoPosts(){
        networkManager.getNewsFeedPhotoPostViaAlamofire(count: 2,completion: { result in
            switch result {
            case let .failure(error):
                print (error)
            case let .success(posts):
                print(posts)
            }
        })

    }
}
