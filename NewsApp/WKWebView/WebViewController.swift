//
//  WebViewController.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 02.10.21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var detailsUrl: String = ""
    weak var webCoordinator: MainCoordinator?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: detailsUrl)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

}
