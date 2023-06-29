//
//  Anime.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/21/23.
//

import Foundation

struct AnimeResponse: Codable {
    let data: [AnimeData]
}

struct AnimeData: Codable {
    let attributes: AnimeAttributes
}

struct AnimeAttributes: Codable {
    let titles: AnimeTitles
}

struct AnimeTitles: Codable {
    let en: String?
    let en_jp: String?
}
