//
//  WebViewController.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/6/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var url: URL?
        myData.getData { (data) in
            for indo in data {
                url = URL(string: indo.url)
            }
        }
        if let currentUrl = url {
            webView.load(URLRequest(url: currentUrl))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
