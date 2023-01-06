import Foundation
import WebKit

class WebViewController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    var name: String
    var webViewSizeController: WebViewSizeController
    
    init(name: String) {
        self.name = name
        self.webViewSizeController = WebViewSizeController.getInstance()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? NSDictionary;
        print(dict ?? "SharinPix null");
        guard let state = dict?["name"] as? String else { return };
        print("SharinPix: " + state);
        if (state == "single-image-loaded") {
            guard let payload = dict?["payload"] as? NSDictionary else { return };
            let image = payload["image"] as? NSDictionary;
            if (image == nil) {
                webViewSizeController.setOpacity(name: name, opacity: 0.0)
            } else {
                webViewSizeController.setOpacity(name: name, opacity: 1.0)
            }
        } else if (state == "upload-started") {
            webViewSizeController.setSize(name: name, newHeight: UIScreen.main.bounds.size.height, newWidth: UIScreen.main.bounds.size.width)
            webViewSizeController.setFullScreen(name: name, fullscreen: true)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
        } else if (state == "image-annotated") {
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
            sendStateToWebApp(state: state)
        }
//        showAlert(message: string)
    }
    
    func sendStateToWebApp(state: String) {
        let response: [String: Any] = [
            "name": "log-message",
            "payload": [
                "state": state,
                "annotated": true
            ],
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject:response)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        if (self.name.elementsEqual("WebView1")) {
            WebView.webView1?.evaluateJavaScript("window.postMessage(" + jsonString! + ")")
        } else if (self.name.elementsEqual("WebView2")) {
            WebView.webView2?.evaluateJavaScript("window.postMessage(" + jsonString! + ")")
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    
                }
            )
            alert.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        });
    }
}
