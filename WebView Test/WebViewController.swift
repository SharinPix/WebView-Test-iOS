import Foundation
import WebKit

class WebViewController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    var name: String
    var webViewSizeController: WebViewSizeController
    
    init(name: String) {
        self.name = name
        self.webViewSizeController = WebViewSizeController.getInstance()
        webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
        webViewSizeController.setFullScreen(name: name, fullscreen: false)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? NSDictionary;
        print(dict ?? "SharinPix null");
        guard let string = dict?["name"] as? String else { return };
        print("SharinPix: " + string);
        if (string == "image-new") {
            webViewSizeController.setSize(name: name, newHeight: UIScreen.main.bounds.size.height, newWidth: UIScreen.main.bounds.size.width)
            webViewSizeController.setFullScreen(name: name, fullscreen: true)
        } else if (string == "image-annotated") {
            webViewSizeController.setSize(name: name, newHeight: 300, newWidth: UIScreen.main.bounds.size.width / 2)
            webViewSizeController.setFullScreen(name: name, fullscreen: false)
        }
        showAlert(message: string)
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )
            
            // Add a confirmation action “OK”
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
