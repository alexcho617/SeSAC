//
//  WebViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.horizontalEdges.equalTo(view)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        //Scroll 할때 컨텐츠를 최대한 보여주기 위해 (웹툰 같은 경우) 네비게이션 바와 탭바를 숨기는 기능도 구현 가능함
        navigationController?.hidesBarsOnSwipe = true
        title = "this is webview"
        
//        webView.hitTest(<#T##CGPoint#>, with: <#T##UIEvent?#>)
    }
}
