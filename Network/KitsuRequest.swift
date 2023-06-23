//
//  KitsuRequest.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/21/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL, requestFailed, unknown, decodingError
}

class AnimeAPI {
    let baseURL = "https://kitsu.io/api/edge/anime"
    
    func fetchAnime() -> Future<AnimeResponse, NetworkError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            var urlComponents = URLComponents(string: self.baseURL)
            urlComponents?.queryItems = [
                URLQueryItem(name: "page[limit]", value: "10"),
                URLQueryItem(name: "page[offset]", value: "0")
            ]
            
            guard let url = urlComponents?.url else {
                return promise(.failure(.badURL))
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let _ = error {
                        promise(.failure(.requestFailed))
                    } else if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let animeResponse = try decoder.decode(AnimeResponse.self, from: data)
                            promise(.success(animeResponse))
                        } catch {
                            promise(.failure(.decodingError))
                        }
                    } else {
                        promise(.failure(.unknown))
                    }
                }
            }
            task.resume()
        }
    }
}


