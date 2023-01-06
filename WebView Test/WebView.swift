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
    
    let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
    
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
            WebView.webView1!.isOpaque = false;
            WebView.webView1!.backgroundColor = UIColor.clear;
            WebView.webView1!.scrollView.contentInsetAdjustmentBehavior = .never
            WebView.webView1!.configuration.userContentController.add(webViewController, name: "sharinpixOnEvent")
            WebView.webView1!.configuration.userContentController.addUserScript(WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
            let request = URLRequest(url: url)
            WebView.webView1!.load(request)
        } else if (name == "WebView2" && WebView.webView2 == nil) {
            print("Creating WebView 2")
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            WebView.webView2 = WKWebView()
            WebView.webView2!.keyboardDisplayRequiresUserAction = false
            WebView.webView2!.scrollView.isScrollEnabled = false
            WebView.webView2!.isOpaque = false;
            WebView.webView2!.backgroundColor = UIColor.clear;
            WebView.webView2!.scrollView.contentInsetAdjustmentBehavior = .never
            WebView.webView2!.configuration.userContentController.add(webViewController, name: "sharinpixOnEvent")
            WebView.webView2!.configuration.userContentController.addUserScript(WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
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

// https://stackoverflow.com/questions/32449870/programmatically-focus-on-a-form-in-a-webview-wkwebview?noredirect=1&lq=1
//The Keyboard is not showing when a Textarea/input is shown on the WebView
// The code below helps to overcome that
typealias OldClosureType =  @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Any?) -> Void
typealias NewClosureType =  @convention(c) (Any, Selector, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void

extension WKWebView{
    var keyboardDisplayRequiresUserAction: Bool? {
        get {
            return self.keyboardDisplayRequiresUserAction
        }
        set {
            self.setKeyboardRequiresUserInteraction(newValue ?? true)
        }
    }

    func setKeyboardRequiresUserInteraction( _ value: Bool) {
        guard let WKContentView: AnyClass = NSClassFromString("WKContentView") else {
            print("keyboardDisplayRequiresUserAction extension: Cannot find the WKContentView class")
            return
        }
        // For iOS 10, *
        let sel_10: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:")
        // For iOS 11.3, *
        let sel_11_3: Selector = sel_getUid("_startAssistingNode:userIsInteracting:blurPreviousNode:changingActivityState:userObject:")
        // For iOS 12.2, *
        let sel_12_2: Selector = sel_getUid("_elementDidFocus:userIsInteracting:blurPreviousNode:changingActivityState:userObject:")
        // For iOS 13.0, *
        let sel_13_0: Selector = sel_getUid("_elementDidFocus:userIsInteracting:blurPreviousNode:activityStateChanges:userObject:")

        if let method = class_getInstanceMethod(WKContentView, sel_10) {
            let originalImp: IMP = method_getImplementation(method)
            let original: OldClosureType = unsafeBitCast(originalImp, to: OldClosureType.self)
            let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3) in
                original(me, sel_10, arg0, !value, arg2, arg3)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }

        if let method = class_getInstanceMethod(WKContentView, sel_11_3) {
            let originalImp: IMP = method_getImplementation(method)
            let original: NewClosureType = unsafeBitCast(originalImp, to: NewClosureType.self)
            let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3, arg4) in
                original(me, sel_11_3, arg0, !value, arg2, arg3, arg4)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }

        if let method = class_getInstanceMethod(WKContentView, sel_12_2) {
            let originalImp: IMP = method_getImplementation(method)
            let original: NewClosureType = unsafeBitCast(originalImp, to: NewClosureType.self)
            let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3, arg4) in
                original(me, sel_12_2, arg0, !value, arg2, arg3, arg4)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }

        if let method = class_getInstanceMethod(WKContentView, sel_13_0) {
            let originalImp: IMP = method_getImplementation(method)
            let original: NewClosureType = unsafeBitCast(originalImp, to: NewClosureType.self)
            let block : @convention(block) (Any, UnsafeRawPointer, Bool, Bool, Bool, Any?) -> Void = { (me, arg0, arg1, arg2, arg3, arg4) in
                original(me, sel_13_0, arg0, !value, arg2, arg3, arg4)
            }
            let imp: IMP = imp_implementationWithBlock(block)
            method_setImplementation(method, imp)
        }
    }
}
