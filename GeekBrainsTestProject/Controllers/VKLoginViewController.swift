//
//  VKLoginViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 23.03.2021.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController, WKNavigationDelegate {

    let vkApiVersion = "5.130"
    let clientId = "7800566"
    let scope = "262150"
    let segueName = "fromWebViewToFriends"

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
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
        webView.load(request)
    }

    // WebView Delegate

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {decisionHandler(.allow)
            return
        }

        let params = fragment
                   .components(separatedBy: "&")
                   .map { $0.components(separatedBy: "=") }
                   .reduce([String: String]()) { result, param in
                       var dict = result
                       let key = param[0]
                       let value = param[1]
                       dict[key] = value
                       return dict
               }
        guard let token = params["access_token"] else { return }
        Session.shared.token = token
        decisionHandler(.cancel)
        getFriendsList()
        getPhotosForCurrentUser()
        getGroupsForCurrentUser()
        getGroupBySearchString(searchString: "Lepra")
        performSegue(withIdentifier: segueName, sender: nil)
    }

    // End of the WebViewDelegate

    func getFriendsList() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "name"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]

        makeUrlRequestWithData(with: urlComponents)
    }

    func getPhotosForCurrentUser() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    func getGroupsForCurrentUser() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "extended", value: "true"),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    func getGroupBySearchString(searchString: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "q", value: searchString),
            URLQueryItem(name: "v", value: vkApiVersion)
        ]
        makeUrlRequestWithData(with: urlComponents)
    }

    private func makeUrlRequestWithData(with urlComponents: URLComponents) {
        let request = URLRequest(url: urlComponents.url!)
        let task = URLSession.shared.dataTask(with: request) {(data, _, _) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task .resume()
    }
}
