//
//  YouTubeExampleView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/28/23.
//

import SwiftUI
import WebKit

struct YouTubeExampleView: View {
    let shareLink = "https://www.youtube.com/watch?v=fJYhWP_O3AI"
    
    var body: some View {
        if let embedUrl = extractVideoIdAndConstructEmbedUrl(shareLink: shareLink) {
            YouTubeVideoPlayerView(youtubeEmbedUrl: embedUrl)
        } else {
            Text("Invalid Share Link")
        }
    }
    
    func extractVideoIdAndConstructEmbedUrl(shareLink: String) -> String? {
        guard let url = URL(string: shareLink),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let pathComponents = URL(string: components.path)?.pathComponents,
              let queryItems = components.queryItems,
              let videoIdItem = queryItems.first(where: { $0.name == "v" }) else { return nil }
        
        guard pathComponents.count > 1, pathComponents[1] == "watch", let videoId = videoIdItem.value else { return nil }
        
        return "https://www.youtube.com/embed/\(videoId)"
    }
}

struct YouTubeVideoPlayerView: View {
    var youtubeEmbedUrl: String

    var body: some View {
        YouTubeWebView(youtubeEmbedUrl: youtubeEmbedUrl)
    }
}

struct YouTubeWebView: UIViewRepresentable {
    let youtubeEmbedUrl: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: youtubeEmbedUrl) {
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
