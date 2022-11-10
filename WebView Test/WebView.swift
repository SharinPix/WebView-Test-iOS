//
//  WebView.swift
//  WebView Test
//
//  Created by Zafir on 10/10/2022.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    var name: String
    var url: URL
    var webViewController: WebViewController
    var webViewSizeController: WebViewSizeController
    
    init(name: String, url: URL, webViewController: WebViewController) {
        self.name = name
        self.url = url
        self.webViewController = webViewController
        self.webViewSizeController = WebViewSizeController.getInstance()
    }
 
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.userContentController.add(webViewController, name: "sharinpixOnEvent")
        webView.scrollView.isScrollEnabled = false
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {}
}
