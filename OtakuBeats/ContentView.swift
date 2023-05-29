//
//  ContentView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 5/10/23.
//

import SwiftUI

//struct ContentView: View {
//    @State private var searchText = ""
//
//    let anime: [Anime] = Anime.mockAnime
//    let songs: [Song] = Song.mockSong
//
//    var filteredAnime: [Anime] {
//        anime.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.title.lowercased().hasPrefix(searchText.lowercased()) }
//    }
//
//    var filteredSongs: [Song] {
//        songs.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.title.lowercased().hasPrefix(searchText.lowercased()) }
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                SearchBar(searchText: $searchText)
//
//                List {
//                    Section(header: Text("Anime")) {
//                        ForEach(filteredAnime) { anime in
//                            Text(anime.title)
//                        }
//                    }
//
//                    Section(header: Text("Songs")) {
//                        ForEach(filteredSongs) { song in
//                            Text(song.title)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Otaku Beats")
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "poop"
    
    let anime: [Anime] = Anime.mockAnime
    let songs: [Song] = Song.mockSong
    
    var filteredAnime: [Anime] {
        anime.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.title.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
    var filteredSongs: [Song] {
        songs.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.title.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                
                if searchText.isEmpty {
                    List(songs) { song in
                        Text(song.title)
                    }
                } else {
                    List {
                        ForEach(filteredAnime) { anime in
                            Text(anime.title)
                        }
                        
                        ForEach(filteredSongs) { song in
                            Text(song.title)
                        }
                    }
                }
            }
            .navigationTitle("Otaku Beats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Filter") {
//                        print("pressed")
//                    }
//                    Menu ("filter"){
//                        Button ("Date") {
//                            print("Pressed")
//                        }
//
//                        Button ("Length") {
//                            print("Pressed")
//                        }
//
//                        Button ("Genre") {
//                            print("Pressed")
//                        }
//
//                    }
                    
                    Picker(selection: .constant(1),
                        label: Text("Filter"),
                           content: {
                        Text("poop")
                        Text("pee")
                    })
                    .pickerStyle(MenuPickerStyle())
                }
            }
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

