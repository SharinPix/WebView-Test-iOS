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
        } else if (state == "image-caption") {
            webViewSizeController.setSize(name: name, newHeight: UIScreen.main.bounds.size.height, newWidth: UIScreen.main.bounds.size.width)
            webViewSizeController.setFullScreen(name: name, fullscreen: true)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
        } else if (state == "image-captioned" || state == "image-caption-closed") {
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
        } else if (state == "upload-started") {
            webViewSizeController.setSize(name: name, newHeight: UIScreen.main.bounds.size.height, newWidth: UIScreen.main.bounds.size.width)
            webViewSizeController.setFullScreen(name: name, fullscreen: true)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
        } else if (state == "annotation-closed") {
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
            webViewSizeController.setOpacity(name: name, opacity: 1.0)
        }
//        showAlert(message: string)
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
