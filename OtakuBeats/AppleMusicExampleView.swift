//
//  AppleMusicExampleView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/29/23.
//

import SwiftUI
import WebKit

struct AppleMusicExampleView: View {
    let shareLink = "https://music.apple.com/us/album/cash-money-millionaires/1440667087?i=1440667404"
    
    var body: some View {
        if let embedUrl = extractIdsAndConstructEmbedUrl(shareLink: shareLink) {
            AppleMusicVideoPlayerView(appleMusicEmbedUrl: embedUrl)
        } else {
            Text("Invalid Share Link")
        }
    }
    
    func extractIdsAndConstructEmbedUrl(shareLink: String) -> String? {
        guard let url = URL(string: shareLink),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems,
              let trackIdItem = queryItems.first(where: { $0.name == "i" }) else {
            return nil
        }
        
        let pathComponents = components.path.split(separator: "/")
        
        guard pathComponents.count > 2, pathComponents[1] == "album", let trackId = trackIdItem.value else {
            return nil
        }
        
        let albumName = pathComponents[2]
        let albumId = pathComponents[3]
        
        return "https://embed.music.apple.com/us/album/\(albumName)/\(albumId)?i=\(trackId)"
    }
}

struct AppleMusicVideoPlayerView: View {
    var appleMusicEmbedUrl: String
    
    var body: some View {
        AppleMusicWebView(appleMusicEmbedUrl: appleMusicEmbedUrl)
    }
}

struct AppleMusicWebView: UIViewRepresentable {
    let appleMusicEmbedUrl: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: appleMusicEmbedUrl) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AppleMusicWebView
        
        init(_ parent: AppleMusicWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Error loading: \(error.localizedDescription)")
        }
    }
}

struct AppleMusicExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AppleMusicExampleView()
    }
}
