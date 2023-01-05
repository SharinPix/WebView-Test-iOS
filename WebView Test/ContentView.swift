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
    @State var _webview1 = WebView1()
    @State var _webview2 = WebView2()
    
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
            url: URL(string: "https://sharinpix-pr-send-nativ-amzucj.herokuapp.com/?token=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzA5NDc4MTYsImlhdCI6MTY3MDkzMzQxNiwiaXNzIjoiYjAzMDU0NDAtNjllZS00OTM0LThhNTAtMjI1MGNmYzNiYjdmIiwicGF0aCI6Ii9zaW5nbGUtaW1hZ2UiLCJ0YWciOiJzZWNvbmRhcnkiLCJJZCI6InBsb3BwbG9wIiwiYWJpbGl0aWVzIjp7InBsb3BwbG9wIjp7IkFjY2VzcyI6eyJzZWUiOnRydWUsImltYWdlX3VwbG9hZCI6dHJ1ZSwiaW1hZ2VfYW5ub3RhdGUiOnRydWUsImltYWdlX2RlbGV0ZSI6dHJ1ZSwiaW1hZ2VfbGlzdCI6dHJ1ZX19fX0.2aWeURNn_VvNAyjXNUyGrR7fA8iG2mDlKAMSyYKDJSw")!,
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
