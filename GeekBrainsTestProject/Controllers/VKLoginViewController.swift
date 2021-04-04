//
//  VKLoginViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 23.03.2021.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController, WKNavigationDelegate {

    let segueToFriendsTableView = "fromWebViewToFriends"
    let networkManager = NetworkManager.shared

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.load(networkManager.formAutoriseVKRequest())
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
        performSegue(withIdentifier: segueToFriendsTableView, sender: nil)
    }
}
