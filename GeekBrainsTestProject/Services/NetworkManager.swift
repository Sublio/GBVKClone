//
//  NetworkManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 29.03.2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit
import PromiseKit

class NetworkManager {

    static let shared = NetworkManager()

    private init () {}

    let vkApiVersion = "5.126"
    let scheme = "https"
    let clientId = "7800566"
    // Wall + Friends + Offline Access
    // Ref - https://vk.com/dev/permissions
    // let scope = 262150 + 8192
    let scope = 65536 + 262150 + 8192
    let oauthHost = "oauth.vk.com"
    let apiHost = "api.vk.com"
    let display = "mobile"

    func formAutoriseVKRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = oauthHost
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "display", value: display),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "\(scope)"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            return request
        }
        return nil

    }

    func getPhotosForUserId(user_id: Int, completion: @escaping (Swift.Result<[Photo], Error>) -> Void) {
        let scheme = "https://"
        let host = self.apiHost
        let path = "/method/photos.get"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "owner_id": user_id,
            "album_id": "wall",
            // "count": 20,
            "v": vkApiVersion
        ]

        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                 guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let itemsJSON = json["response"]["items"].arrayValue
                let photos = itemsJSON.compactMap({Photo(json: $0)})
                completion(.success(photos))
            }
        }
    }

    func getPhotoAlbumsForUserId(user_id: Int, completion: @escaping (Swift.Result<[PhotoAlbum], Error>) -> Void) {
        let scheme = "https://"
        let host = self.apiHost
        let path = "/method/photos.getAlbums"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "owner_id": user_id,
            "v": vkApiVersion
        ]
        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let itemsJSON = json["response"]["items"].arrayValue
                let photoAlbums = itemsJSON.compactMap({PhotoAlbum(json: $0)})
                completion(.success(photoAlbums))
            }
        }
    }

    func getGroupsBySearchString(searchString: String, completion: @escaping (Swift.Result<[SearchableGroup], Error>) -> Void) {

        let scheme = "https://"
        let host = self.apiHost
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "q": searchString,
            "v": vkApiVersion,
            "count": 30
        ]

        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let groupJSON = json["response"]["items"].arrayValue
                let groups = groupJSON.map { SearchableGroup(json: $0) }

                completion(.success(groups))
            }
        }

    }

    func getFriendsListViaAlamoFire(completion: @escaping (Swift.Result<[Friend], Error>) -> Void) {

        let scheme = "https://"
        let host = self.apiHost
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "fields": "name, photo_50",
            "v": vkApiVersion
        ]

        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let friendsJSON = json["response"]["items"].arrayValue
                let friends = friendsJSON.map { Friend(json: $0) }

                completion(.success(friends))
            }
        }
    }

    func getFriendListViaPromises() -> Promise<[Friend]> {
        let scheme = "https://"
        let host = self.apiHost
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "fields": "name, photo_50",
            "v": vkApiVersion
        ]

        return Promise.init { resolver in
            AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
                switch response.result {
                case .failure(let error):
                    resolver.reject(error)
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let json = try JSON(data: data)
                        let friendsJSON = json["response"]["items"].arrayValue
                        let friends = friendsJSON.map { Friend(json: $0) }
                        resolver.fulfill(friends)
                    } catch {
                        resolver.reject(error)
                    }
                }
            }
        }
    }
}
