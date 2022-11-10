//
//  WebViewSizeController.swift
//  WebView Test
//
//  Created by Zafir on 10/11/2022.
//

import Foundation

class WebViewSizeController: ObservableObject {
    static var webViewSizeController: WebViewSizeController?;
    
    @Published var webViewHeight1: CGFloat = 300
    @Published var webViewHeight2: CGFloat = 300
    @Published var webViewWidth1: CGFloat = 300
    @Published var webViewWidth2: CGFloat = 300
    @Published var webView1FullScreen = false
    @Published var webView2FullScreen = false
    
    static func getInstance() -> WebViewSizeController {
        if ((webViewSizeController == nil)) {
            webViewSizeController = WebViewSizeController();
        }
        return webViewSizeController!
    }
    
    func setSize(name: String, newHeight: CGFloat, newWidth: CGFloat) {
        if (name == "WebView1") {
            self.webViewHeight1 = newHeight
            self.webViewWidth1 = newWidth
        } else if (name == "WebView2") {
            self.webViewHeight2 = newHeight
            self.webViewWidth2 = newWidth
        }
    }
    
    func setFullScreen(name: String, fullscreen: Bool) {
        if (name == "WebView1") {
            if (fullscreen) {
                self.webView1FullScreen = true
            } else {
                self.webView1FullScreen = false
            }
        } else if (name == "WebView2") {
            if (fullscreen) {
                self.webView2FullScreen = true
            } else {
                self.webView2FullScreen = false
            }
        }
    }
}
