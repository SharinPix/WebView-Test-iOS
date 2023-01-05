//
//  WebViewSizeController.swift
//  WebView Test
//
//  Created by Zafir on 10/11/2022.
//

import Foundation
import UIKit

class WebViewSizeController: ObservableObject {
    static var webViewSizeController: WebViewSizeController?;
    
    @Published var webViewHeight1: CGFloat = 300
    @Published var webViewHeight2: CGFloat = 300
    @Published var webViewWidth1: CGFloat = 300
    @Published var webViewWidth2: CGFloat = 300
    @Published var webView1FullScreen = false
    @Published var webView2FullScreen = false
    @Published var webView1Opacity = 0.0
    @Published var webView2Opacity = 0.0
    @Published var webview1TopPadding = 0.0
    @Published var webview2TopPadding = 0.0
    
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
    
    func setOpacity(name: String, opacity: CGFloat) {
        if (name == "WebView1") {
            webView1Opacity = opacity;
            WebView.webView1?.evaluateJavaScript("document.documentElement.style.opacity = \(opacity)");
        } else if (name == "WebView2") {
            webView2Opacity = opacity;
            WebView.webView2?.evaluateJavaScript("document.documentElement.style.opacity = \(opacity)");
        }
    }
    
    func setFullScreen(name: String, fullscreen: Bool) {
        if (name == "WebView1") {
            if (fullscreen) {
                self.webView1FullScreen = true
                WebView.webView1!.scrollView.contentInset = UIEdgeInsets(top: 40.0, left: 0, bottom: 0, right: 0)
                setKeyboardListener(enable: true, name: name)
            } else {
                self.webView1FullScreen = false
                if ((WebView.webView1) != nil) {
                    WebView.webView1!.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                setKeyboardListener(enable: false, name: name)
            }
        } else if (name == "WebView2") {
            if (fullscreen) {
                self.webView2FullScreen = true
                WebView.webView2!.scrollView.contentInset = UIEdgeInsets(top: 40.0, left: 0, bottom: 0, right: 0)
                setKeyboardListener(enable: true, name: name)
            } else {
                self.webView2FullScreen = false
                if ((WebView.webView2) != nil) {
                    WebView.webView2!.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                setKeyboardListener(enable: false, name: name)
            }
        }
    }
    
    func setKeyboardListener(enable: Bool, name: String) {
        if (enable) {
            if (name == "WebView1") {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideWebView1), name: UIResponder.keyboardWillHideNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowWebView1), name: UIResponder.keyboardWillShowNotification, object: nil)
            } else if (name == "WebView2") {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideWebView2), name: UIResponder.keyboardWillHideNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowWebView2), name: UIResponder.keyboardWillShowNotification, object: nil)
            }
        } else {
            if (name == "WebView1") {
                NotificationCenter.default.removeObserver(#selector(keyboardWillHideWebView1))
                NotificationCenter.default.removeObserver(#selector(keyboardWillShowWebView1))
            } else if (name == "WebView2") {
                NotificationCenter.default.removeObserver(#selector(keyboardWillHideWebView2))
                NotificationCenter.default.removeObserver(#selector(keyboardWillShowWebView2))
            }
        }
    }
    
    @objc func keyboardWillShowWebView1(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            webview1TopPadding = keyboardHeight - WebView.webView1!.safeAreaInsets.top
        }
    }
    
    @objc func keyboardWillShowWebView2(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            webview2TopPadding = keyboardHeight - WebView.webView2!.safeAreaInsets.top
        }
    }
    
    @objc func keyboardWillHideWebView1(notification: NSNotification) {
        webview1TopPadding = 0
    }
    
    @objc func keyboardWillHideWebView2(notification: NSNotification) {
        webview2TopPadding = 0
    }
}
