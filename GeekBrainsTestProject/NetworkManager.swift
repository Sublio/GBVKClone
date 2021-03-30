//
//  NetworkManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 29.03.2021.
//

import Foundation
import SwiftyJSON

class NetworkManager {

    let vkApiVersion = "5.130"
    let scheme = "https"
    let clientId = "7800566"
    let scope = "262150"
    let oauthHost = "oauth.vk.com"
    let apiHost = "api.vk.com"

    func formAutoriseVKRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = oauthHost
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    func getGroupBySearchString(searchString: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "q", value: searchString),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    func getGroupsForCurrentUser() {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "extended", value: "true"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    func getPhotosForCurrentUser() {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    func getFriendsList(completion: @escaping (Result<[Friend], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            // URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "fields", value: "name, photo_50"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]

        let request = URLRequest(url: urlComponents.url!)
        let task = URLSession.shared.dataTask(with: request) {(data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data,
                  let json = try? JSON(data: data) else { return }

            let friendsJSON = json["response"]["items"].arrayValue
            let friends = friendsJSON.map {Friend(json: $0)}
            completion(.success(friends))
        }
        task .resume()
    }

    private func makeUrlRequestWithData(with urlComponents: URLComponents) {
        let request = URLRequest(url: urlComponents.url!)
        let task = URLSession.shared.dataTask(with: request) {(data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data,
                  let _ = try? JSON(data: data) else { return }

        }
        task .resume()
    }
}
