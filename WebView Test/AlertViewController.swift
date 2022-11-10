//
//  AlertViewController.swift
//  WebView Test
//
//  Created by Zafir on 13/10/2022.
//
import Foundation
import UIKit

class AlertViewController: UIViewController {
    
    static var alertViewController: AlertViewController = AlertViewController()
    
    static func showAlert(message: String) {
        let alert = UIAlertController(title: "SharinPix", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in }));
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in }));
        DispatchQueue.main.async { alertViewController.present(alert, animated: false, completion: nil) }
    }
}
