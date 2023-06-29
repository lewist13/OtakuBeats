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

        // MARK: - Coordinator Creation
    
        /// This function is called to create a coordinator instance.
        /// The coordinator is not strictly necessary for the basic functionality
        /// of the WebView, but it is useful for responding to WebView's lifecycle
        /// events and communicating back to the YouTubeWebView.
        ///
        /// - Returns: A new Coordinator instance.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
        // MARK: - Coordinator Class
    
        /// The Coordinator class acts as a delegate for the WebView, allowing
        /// the handling of navigation events, loading errors, and other web content-related events.
        /// While not essential for loading a YouTube video, it is useful for handling errors and
        /// other web navigation events in a more sophisticated manner.
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubeWebView
        
        init(_ parent: YouTubeWebView) {
            self.parent = parent
        }
        
            /// Called when the WebView’s web content process is terminated.
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
