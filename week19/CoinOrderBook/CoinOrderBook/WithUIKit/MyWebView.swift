//
//  MyWebView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 11/27/23.
//

//SwiftUI에 UIKit 활용하기
import Foundation
import SwiftUI
import WebKit


struct MyWebView: UIViewRepresentable{
    let urlString: String
    //typealias 써도 상관없음
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlString) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    //이건 뭐지
//    func makeCoordinator() -> () {
//        <#code#>
//    }
    
    
}
