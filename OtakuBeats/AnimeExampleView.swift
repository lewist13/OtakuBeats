//
//  AnimeTestView.swift
//  OtakuBeats
//
//  Created by TaeVon Lewis on 6/21/23.
//

import SwiftUI

struct AnimeListView: View {
    @StateObject private var viewModel = AnimeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .font(.headline)
                } else {
                    if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                            .font(.headline)
                    } else {
                        ScrollView {
                            AnimeList(animeTitles: viewModel.animeTitlesEn, title: "English Titles")
                            AnimeList(animeTitles: viewModel.animeTitlesEnJp, title: "English-Japanese Titles")
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Anime Titles")
            .onAppear {
                viewModel.fetchAnime()
            }
        }
    }
}

struct AnimeList: View {
    let animeTitles: [String]
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(animeTitles, id: \.self) { title in
                Text(title)
                    .font(.body)
                    .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListView()
    }
}
