//
//  WebViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: BaseViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func reloadButtonClicked(){
        webView.reload()
    }
    func backButtonClicked(){
        if webView.canGoBack {webView.goBack()}
    }
    func forwardButtonClicked(){
        if webView.canGoForward {webView.goForward()}
    }
}
