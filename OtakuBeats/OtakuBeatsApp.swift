//
//  OtakuBeatsApp.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 5/10/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

struct CombinedView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go to ContentView", destination: ContentView())
                NavigationLink("Go to Anime Fetch Example", destination: AnimeListView())
                NavigationLink("Go to YouTube Example", destination: YouTubeExampleView())
                NavigationLink("Go to Spotify Example", destination: SpotifyExampleView())
                NavigationLink("Go to Apple Music Example", destination: AppleMusicExampleView())
            }
        }
    }
}

@main
struct OtakuBeatsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            CombinedView()
        }
    }
}
