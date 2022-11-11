//
//  WebView.swift
//  WebView Test
//
//  Created by Zafir on 10/10/2022.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    static var webView1: WKWebView?
    static var webView2: WKWebView?
    
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
        if (name == "WebView1" && WebView.webView1 == nil) {
            print("Creating WebView 1")
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            WebView.webView1 = WKWebView()
            WebView.webView1!.scrollView.isScrollEnabled = false
            WebView.webView1!.clipsToBounds = true
            WebView.webView1!.configuration.userContentController.add(webViewController, name: "sharinpixOnEvent")
            let request = URLRequest(url: url)
            WebView.webView1!.load(request)
        } else if (name == "WebView2" && WebView.webView2 == nil) {
            print("Creating WebView 2")
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            WebView.webView2 = WKWebView()
            WebView.webView2!.scrollView.isScrollEnabled = false
            WebView.webView2!.clipsToBounds = true
            WebView.webView2!.configuration.userContentController.add(webViewController, name: "sharinpixOnEvent")
            let request = URLRequest(url: url)
            WebView.webView2!.load(request)
        }
        if (name == "WebView1") {
            return WebView.webView1!
        }
        return WebView.webView2!
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        print("WebView Updated")
    }
}
