//
//  WebViewEventController.swift
//  WebView Test
//
//  Created by Zafir on 31/01/2023.
//

import Foundation

class WebViewEventController: ObservableObject {
    static var webViewEventController: WebViewEventController?;
    
    static func getInstance() -> WebViewEventController {
        if ((webViewEventController == nil)) {
            webViewEventController = WebViewEventController();
        }
        return webViewEventController!
    }
    
    func sendCaptionToWebApp(name: String, title: String, description: String) {
        let response: [String: Any] = [
            "name": "update-caption",
            "payload": [
                "title": title,
                "description": description
            ],
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject:response)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        if (name == "WebView1") {
            WebView.webView1?.evaluateJavaScript("window.postMessage(" + jsonString! + ")")
        } else if (name == "WebView2") {
            WebView.webView2?.evaluateJavaScript("window.postMessage(" + jsonString! + ")")
        }
    }
}
