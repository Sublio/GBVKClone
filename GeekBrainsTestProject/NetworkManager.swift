//
//  NetworkManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 29.03.2021.
//

import Foundation

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

    func getFriendsList() {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "name"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]

        makeUrlRequestWithData(with: urlComponents)
    }

//    getFriendsList()
//    getPhotosForCurrentUser()
//    getGroupsForCurrentUser()
//    getGroupBySearchString(searchString: "Lepra")

    private func makeUrlRequestWithData(with urlComponents: URLComponents) {
        let request = URLRequest(url: urlComponents.url!)
        let task = URLSession.shared.dataTask(with: request) {(data, responce, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task .resume()
    }
}
