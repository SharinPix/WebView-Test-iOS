//
//  ContentView.swift
//  WebView Test
//
//  Created by Zafir on 10/10/2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @ObservedObject var webViewSizeController: WebViewSizeController = WebViewSizeController.getInstance()
    @ObservedObject var webViewEventController: WebViewEventController = WebViewEventController.getInstance()
    @State var _webview1 = WebView1()
    @State var _webview2 = WebView2()
    
    @State private var presentAlert1 = false
    @State private var presentAlert2 = false
    @State private var titleAlert: String = ""
    @State private var descriptionAlert: String = ""
    
    var body: some View {
        if (!webViewSizeController.webView1FullScreen && !webViewSizeController.webView2FullScreen) {
        Color.black
            .overlay(
                ScrollView {
                    VStack {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                .padding()
                                .foregroundColor(.white)
                                .font(.headline)
                            HStack {
                                _webview1
                                _webview2
                            }
                    }
                }
            )
            Button("Send Caption to WebView 1") {
                presentAlert1 = true
            }
            .alert("WebView 1 Caption", isPresented: $presentAlert1, actions: {
                TextField("Title", text: $titleAlert)
                TextField("Description", text: $descriptionAlert)
                Button("Send Caption", action: {
                    webViewEventController.sendCaptionToWebApp(name: "WebView1", title: titleAlert, description: descriptionAlert)
                    presentAlert1 = false
                    titleAlert = ""
                    descriptionAlert = ""
                })
                Button("Cancel", role: .cancel, action: {
                    presentAlert1 = false
                    titleAlert = ""
                    descriptionAlert = ""
                })
            }, message: {
                Text("Please enter the title and desciption to be send.")
            })
            Spacer()
            Button("Send Caption to WebView 2") {
                presentAlert2 = true
            }
            .alert("WebView 2 Caption", isPresented: $presentAlert2, actions: {
                TextField("Title", text: $titleAlert)
                TextField("Description", text: $descriptionAlert)
                Button("Send Caption", action: {
                    webViewEventController.sendCaptionToWebApp(name: "WebView2", title: titleAlert, description: descriptionAlert)
                    presentAlert2 = false
                    titleAlert = ""
                    descriptionAlert = ""
                })
                Button("Cancel", role: .cancel, action: {
                    presentAlert2 = false
                    titleAlert = ""
                    descriptionAlert = ""
                })
            }, message: {
                Text("Please enter the title and desciption to be send.")
            })
        } else {
            if (webViewSizeController.webView1FullScreen) {
                _webview1.padding([.top], $webViewSizeController.webview1TopPadding.wrappedValue)
            } else if (webViewSizeController.webView2FullScreen) {
                _webview2.padding([.top], $webViewSizeController.webview2TopPadding.wrappedValue)
            }
        }
    }
}

struct WebView1: View {
    @ObservedObject var webViewSizeController: WebViewSizeController = WebViewSizeController.getInstance()
    
    var body: some View {
        WebView(
            name: "WebView1",
            url: URL(string: "https://sharinpix-pr-image-capt-tzte8u.herokuapp.com/?token=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzU0MTg2OTgsImlhdCI6MTY3NTQwNDI5OCwidXNlcl9pZCI6ImI1Y2VhZjlkLWU5NzEtNDI1Ni05OTg3LTg5Y2MxNzNiY2VlMSIsImlzcyI6IjVhODJmNTQzLTRlMTQtNGE5YS05MTI5LWJmMzg5ZmY0MzZjMiIsInBhdGgiOiIvc2luZ2xlLWltYWdlIiwidGFnIjoic2Vjb25kYXJ5IiwiSWQiOiIwMDMyNDAwMDAwNDZ5TEFBQUEiLCJhYmlsaXRpZXMiOnsiMDAzMjQwMDAwMDQ2eUxBQUFBIjp7IkFjY2VzcyI6eyJzZWUiOnRydWUsImltYWdlX3VwbG9hZCI6dHJ1ZSwiaW1hZ2VfY3JvcCI6ZmFsc2UsImltYWdlX2RlbGV0ZSI6dHJ1ZSwiaW1hZ2VfbGlzdCI6dHJ1ZSwiaW1hZ2VfY2FwdGlvbiI6dHJ1ZX19fSwiZW1iZXIiOiJ0cnVlIn0.1UlIvX9JCVd_ufwGOaGOit-FMdhXNXyGRc8MEZy6XpY")!,
            webViewController: WebViewController(name: "WebView1")
        )
        .frame(width: $webViewSizeController.webViewWidth1.wrappedValue, height: $webViewSizeController.webViewHeight1.wrappedValue)
        .overlay(
            Text("Front Image")
                .foregroundStyle(.white.gradient)
                .opacity($webViewSizeController.webView1Opacity.wrappedValue == 1.0 ? 0.0 : 1.0)
        )
    }
}

struct WebView2: View {
    @ObservedObject var webViewSizeController: WebViewSizeController = WebViewSizeController.getInstance()
    
    var body: some View {
        WebView(
            name: "WebView2",
            url: URL(string: "https://app.sharinpix.com/?token=eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjgwODA5MzcsImlzcyI6ImQ2NWZiOWRjLWUwOTItNDg0OC04MWRhLWFiNjJiMzQ4MTA3NCIsInBhdGgiOiIvc2luZ2xlLWltYWdlIiwidGFnIjoicmVjZWlwdDIiLCJJZCI6IjUwMDI0MDAwMDAxRm1BTkFBMCIsImFiaWxpdGllcyI6eyI1MDAyNDAwMDAwMUZtQU5BQTAiOnsiQWNjZXNzIjp7InNlZSI6dHJ1ZSwiaW1hZ2VfdXBsb2FkIjp0cnVlLCJpbWFnZV9jcm9wIjp0cnVlLCJpbWFnZV9saXN0Ijp0cnVlLCJpbWFnZV9hbm5vdGF0ZSI6dHJ1ZSwiaW1hZ2VfZGVsZXRlIjp0cnVlfX19LCJ1cGxvYWRfc291cmNlIjoiY2FtZXJhIiwidXBsb2FkX2FjY2VwdCI6ImltYWdlLyoifQ.WXQkfusPeLondFHrjJt_eb_5Iu19JLG6nfP8FkLl4Ko")!,
            webViewController: WebViewController(name: "WebView2")
        )
        .frame(width: $webViewSizeController.webViewWidth2.wrappedValue, height: $webViewSizeController.webViewHeight2.wrappedValue)
        .overlay(
            Text("Back Image")
                .foregroundStyle(.white.gradient)
                .opacity($webViewSizeController.webView2Opacity.wrappedValue == 1.0 ? 0.0 : 1.0)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
