//
//  NetworkManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 29.03.2021.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    private init () {}

    let vkApiVersion = "5.130"
    let scheme = "https"
    let clientId = "7812924"
    let scope = "65536"
    let oauthHost = "oauth.vk.com"
    let apiHost = "api.vk.com"
    let display = "mobile"

    func formAutoriseVKRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = oauthHost
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "display", value: display),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    func getPhotosForUserId(user_id: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let scheme = "https://"
        let host = "api.vk.com"
        let path = "/method/photos.get"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "owner_id": user_id,
            "album_id": "wall",
            "count": 20,
            "v": vkApiVersion
        ]

        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            var results: [Photo] = []
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let itemsJSON = json["response"]["items"].arrayValue
                for item in itemsJSON {
                    let pictureSizesArray = item["sizes"].arrayValue
                    let mediumPictureSize = pictureSizesArray[2] // large size
                    let photo = Photo(json: mediumPictureSize)
                    results.append(photo)
                }
                completion(.success(results))
            }
        }
    }

    func getGroupsBySearchString(searchString: String, completion: @escaping (Result<[Group], Error>) -> Void) {

        let scheme = "https://"
        let host = "api.vk.com"
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "q": searchString,
            "v": vkApiVersion
        ]

        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let groupJSON = json["response"]["items"].arrayValue
                let groups = groupJSON.map { Group(json: $0) }

                completion(.success(groups))
            }
        }

    }

    func getGroupsForCurrentUserViaAlamofire(completion: @escaping (Result<[Group], Error>) -> Void) {

        let scheme = "https://"
        let host = "api.vk.com"
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "extended": "true",
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
                let groupJSON = json["response"]["items"].arrayValue
                let groups = groupJSON.map { Group(json: $0) }

                completion(.success(groups))
            }
        }
    }

    func getFriendsListViaAlamoFire(completion: @escaping (Result<[Friend], Error>) -> Void) {

        let scheme = "https://"
        let host = "api.vk.com"
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

    func getData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
