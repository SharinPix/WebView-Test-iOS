import Foundation
import WebKit

class WebViewController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    var name: String
    var webViewHeightController: WebViewHeightController
    
    init(name: String) {
        self.name = name
        self.webViewHeightController = WebViewHeightController.getInstance()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? NSDictionary;
        print(dict ?? "SharinPix null");
        guard let string = dict?["name"] as? String else { return };
        print("SharinPix: " + string);
        if (string == "upload-done") {
            webViewHeightController.setHeight(name: name, newHeight: 800)
        } else if (string == "image-annotated") {
            webViewHeightController.setHeight(name: name, newHeight: 300)
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
