//
//  AnimeRequestTests.swift
//  OtakuBeatsTests
//
//  Created by TaeVon Lewis on 6/29/23.
//

import XCTest
import Combine
@testable import OtakuBeats

class AnimeAPIMock: AnimeAPI {
    var shouldReturnError = false
    
    override func fetchAnime() -> Future<AnimeResponse, NetworkError> {
        return Future { promise in
            if self.shouldReturnError {
                promise(.failure(.unknown))
            } else {
                let mockAnimeTitles = AnimeTitles(en: "Naruto", en_jp: "ナルト")
                let mockAnimeAttributes = AnimeAttributes(titles: mockAnimeTitles)
                let mockAnimeData = AnimeData(attributes: mockAnimeAttributes)
                let mockAnimeResponse = AnimeResponse(data: [mockAnimeData])
                promise(.success(mockAnimeResponse))
            }
        }
    }
}

class AnimeViewModelMock: AnimeViewModel {
    let mockAPI: AnimeAPIMock
    private var cancellablesForTesting = Set<AnyCancellable>()
    
    init(mockAPI: AnimeAPIMock) {
        self.mockAPI = mockAPI
        super.init()
    }
    
    override func fetchAnime() {
        self.isLoading = true
        self.error = nil
        
        mockAPI.fetchAnime()
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
            .store(in: &cancellablesForTesting)
    }
}

final class AnimeRequestTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchAnime() {
        let expectation = XCTestExpectation(description: "Fetch anime data")
        let animeAPIMock = AnimeAPIMock()
        let viewModelMock = AnimeViewModelMock(mockAPI: animeAPIMock)
        
        viewModelMock.fetchAnime()
        
        viewModelMock.$isLoading.sink { isLoading in
            if !isLoading {
                XCTAssertFalse(viewModelMock.animeTitlesEn.isEmpty)
                XCTAssertFalse(viewModelMock.animeTitlesEnJp.isEmpty)
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAnimeViewModelSuccess() {
        let expectation = XCTestExpectation(description: "AnimeViewModel fetches and processes data")
        
        let mockAPI = AnimeAPIMock()
        let animeViewModel = AnimeViewModelMock(mockAPI: mockAPI)
        
        animeViewModel.$animeTitlesEn
            .sink { titles in
                if !titles.isEmpty {
                    XCTAssertEqual(titles.first, "Naruto")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        animeViewModel.fetchAnime()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAnimeViewModelError() {
        let expectation = XCTestExpectation(description: "AnimeViewModel handles error")
        
        let mockAPI = AnimeAPIMock()
        mockAPI.shouldReturnError = true
        
        let animeViewModel = AnimeViewModelMock(mockAPI: mockAPI)
        
        animeViewModel.$error
            .sink { error in
                if error != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        animeViewModel.fetchAnime()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
