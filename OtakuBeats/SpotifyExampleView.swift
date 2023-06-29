//
//  SpotifyExampleView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/29/23.
//

import SwiftUI
import WebKit

struct SpotifyExampleView: View {
    let shareLink = "https://open.spotify.com/track/0AAMnNeIc6CdnfNU85GwCH?si=6896b3492e414cd0"

    var body: some View {
        if let embedUrl = extractTrackIdAndConstructEmbedUrl(shareLink: shareLink) {
            SpotifyVideoPlayerView(spotifyEmbedUrl: embedUrl)
        } else {
            Text("Invalid Share Link")
        }
    }
    
    func extractTrackIdAndConstructEmbedUrl(shareLink: String) -> String? {
        guard let url = URL(string: shareLink),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let pathComponents = URL(string: components.path)?.pathComponents,
              pathComponents.count > 1,
              pathComponents[1] == "track" else {
            return nil
        }
        let trackId = pathComponents[2]
        return "https://open.spotify.com/embed/track/\(trackId)"
    }
}

struct SpotifyVideoPlayerView: View {
    var spotifyEmbedUrl: String
    
    var body: some View {
        SpotifyWebView(spotifyEmbedUrl: spotifyEmbedUrl)
    }
}

struct SpotifyWebView: UIViewRepresentable {
    let spotifyEmbedUrl: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: spotifyEmbedUrl) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: SpotifyWebView
        
        init(_ parent: SpotifyWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Error loading: \(error.localizedDescription)")
        }
    }
}

struct SpotifyExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyExampleView()
    }
}
