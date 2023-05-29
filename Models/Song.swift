//
//  SongModel.swift
//  OtakuBeats
//
//  Created by Derrick on 5/10/23.
//

import SwiftUI

struct Anime: Identifiable {
    let id = UUID()
    
    // Kitsu API info
    let title: String
    let titleJap: String
    let posterImgUrl: String
}

struct Song: Identifiable {
    let id = UUID()
    
    let animeId: Int
    let genre: String
    let length: Int
    let title: String
    let type: String
    let youtubeUrl: String
    //let uploadDate:
    //let uploaderId:
    
}

extension Anime {
    static var mockAnime: [Anime] = [
        Anime(title: "Cowboy Bebop", titleJap: "Cowbop Bebop", posterImgUrl: " "),
        Anime(title: "Naruto", titleJap: "Naruto", posterImgUrl: " ")
    ]
}

extension Song {
    static var mockSong: [Song] = [
        Song(animeId: 1, genre: "Jazz", length: Int(3.31), title: "Tank!", type: " ", youtubeUrl: "https://www.youtube.com/watch?v=UFFa0QoHWvE")
    ]
}


//user struct to be implemented later into the project




