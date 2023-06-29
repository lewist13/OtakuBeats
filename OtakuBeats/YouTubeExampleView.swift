//
//  YouTubeExampleView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/28/23.
//

import SwiftUI
import WebKit

struct YouTubeExampleView: View {
    var body: some View {
        YouTubeVideoPlayerView(videoId: "fJYhWP_O3AI")
    }
}

struct YouTubeVideoPlayerView: View {
    var videoId: String

    var body: some View {
        YouTubeWebView(videoId: videoId)
    }
}

struct YouTubeWebView: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedUrl = "https://www.youtube.com/embed/\(videoId)"
        if let url = URL(string: embedUrl) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubeWebView

        init(_ parent: YouTubeWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Error loading: \(error.localizedDescription)")
        }
    }
}

struct YouTubeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeExampleView()
    }
}
