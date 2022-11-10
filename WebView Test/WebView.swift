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
    
    init(name: String, url: URL, webViewController: WebViewController) {
        self.name = name
        self.url = url
        self.webViewController = webViewController
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


class WebViewHeightController: ObservableObject {
    static var webViewHeightController: WebViewHeightController?;
    
    @Published var webViewHeight1: CGFloat = 300
    @Published var webViewHeight2: CGFloat = 300
    
    static func getInstance() -> WebViewHeightController {
        if ((webViewHeightController == nil)) {
            webViewHeightController = WebViewHeightController();
        }
        return webViewHeightController!
    }
    
    func setHeight(name: String, newHeight: CGFloat) {
        if (name == "WebView1") {
            self.webViewHeight1 = newHeight
        } else {
            self.webViewHeight2 = newHeight
        }
    }
}
