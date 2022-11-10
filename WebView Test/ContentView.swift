//
//  ContentView.swift
//  WebView Test
//
//  Created by Zafir on 10/10/2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @ObservedObject var webViewHeightController: WebViewHeightController = WebViewHeightController.getInstance()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("WebView1")
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .font(.headline)
                WebView(
                    name: "WebView1",
                    url: URL(string: "https://app.sharinpix.com/?token=eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjgwODA5MzcsImlzcyI6ImQ2NWZiOWRjLWUwOTItNDg0OC04MWRhLWFiNjJiMzQ4MTA3NCIsInBhdGgiOiIvc2luZ2xlLWltYWdlIiwidGFnIjoicmVjZWlwdCIsIklkIjoiNTAwMjQwMDAwMDFGbUFOQUEwIiwiYWJpbGl0aWVzIjp7IjUwMDI0MDAwMDAxRm1BTkFBMCI6eyJBY2Nlc3MiOnsic2VlIjp0cnVlLCJpbWFnZV91cGxvYWQiOnRydWUsImltYWdlX2Nyb3AiOnRydWUsImltYWdlX2xpc3QiOnRydWUsImltYWdlX2Fubm90YXRlIjp0cnVlfX19LCJ1cGxvYWRfc291cmNlIjoiY2FtZXJhIiwidXBsb2FkX2FjY2VwdCI6ImltYWdlLyoifQ.aIYoqbJmGtiutRECTHyebshzMr07A7eXRpkPPUU9V_E")!,
                    webViewController: WebViewController(name: "WebView1")
                ).frame(height: $webViewHeightController.webViewHeight1.wrappedValue)
                Text("WebView2")
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .font(.headline)
                WebView(
                    name: "WebView2",
                    url: URL(string: "https://app.sharinpix.com/?token=eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjgwODA5MzcsImlzcyI6ImQ2NWZiOWRjLWUwOTItNDg0OC04MWRhLWFiNjJiMzQ4MTA3NCIsInBhdGgiOiIvc2luZ2xlLWltYWdlIiwidGFnIjoicmVjZWlwdDIiLCJJZCI6IjUwMDI0MDAwMDAxRm1BTkFBMCIsImFiaWxpdGllcyI6eyI1MDAyNDAwMDAwMUZtQU5BQTAiOnsiQWNjZXNzIjp7InNlZSI6dHJ1ZSwiaW1hZ2VfdXBsb2FkIjp0cnVlLCJpbWFnZV9jcm9wIjp0cnVlLCJpbWFnZV9saXN0Ijp0cnVlLCJpbWFnZV9hbm5vdGF0ZSI6dHJ1ZSwiaW1hZ2VfZGVsZXRlIjp0cnVlfX19LCJ1cGxvYWRfc291cmNlIjoiY2FtZXJhIiwidXBsb2FkX2FjY2VwdCI6ImltYWdlLyoifQ.WXQkfusPeLondFHrjJt_eb_5Iu19JLG6nfP8FkLl4Ko")!,
                    webViewController: WebViewController(name: "WebView2")
                ).frame(height: $webViewHeightController.webViewHeight2.wrappedValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
