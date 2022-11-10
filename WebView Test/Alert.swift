//
//  Alert.swift
//  WebView Test
//
//  Created by Zafir on 13/10/2022.
//
import Foundation
import UIKit

struct CustomAlert: UIViewControllerRepresentable {
    @Binding var shouldShow: Bool
    
    func makeUIViewController(context: Context) -> CustomAlertController {
        return CustomAlertController()
    }
    
    func updateUIViewController(_ uiViewController: CustomAlertController, context: Context) {
        if shouldShow {
            uiViewController.showAlert()
        }
    }
}
