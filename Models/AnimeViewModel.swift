//
//  AnimeViewModel.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/21/23.
//

import SwiftUI
import Combine

class AnimeViewModel: ObservableObject {
    @Published var animeTitlesEn = [String]()
    @Published var animeTitlesEnJp = [String]()
    @Published var error: NetworkError?
    @Published var isLoading = false
    
    private var animeAPI = AnimeAPI()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAnime() {
        self.isLoading = true
        self.error = nil
        
        animeAPI.fetchAnime()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { [weak self] animeResponse in
                guard let self = self else { return }
                self.animeTitlesEn = animeResponse.data.compactMap { $0.attributes.titles.en }
                self.animeTitlesEnJp = animeResponse.data.compactMap { $0.attributes.titles.en_jp }
            }
            .store(in: &cancellables)
    }
}


