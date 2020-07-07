//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    @Binding var sport: Sport?
    
    @State private var games: [Game] = []
    
    @State private var isFetchingGames = true
    
    private let httpClient = HttpClient()
    
    var body: some View {
        VStack {
            SheetToolbarView(dismissAction: dismiss)
            Spacer()
            Group {
                if isFetchingGames {
                    LoadingView(message: NSLocalizedString("GamesListViewLoading",
                                                           value: "Fetching games...",
                                                           comment: "Shown when games data is being fetched."))
                } else if let sport = sport, !games.isEmpty {
                    List {
                        ListHeaderView(title: sport.league)
                        ForEach(games) { game in
                            GameCell(game: game)
                        }
                    }
                } else {
                    EmptyStateView(message: NSLocalizedString("GamesListViewEmptyState",
                                                              value: "Sorry, couldn't find any games today. :)",
                                                              comment: "Shown when games data is not available."))
                }
            }
            Spacer()
        }
        .onAppear { loadGames() }
    }
    
    private func dismiss() {
        sport = nil
    }
    
    private func loadGames() {
        isFetchingGames = true
        guard let sport = sport else {
            isFetchingGames = false
            return
        }
        httpClient.getGames(league: sport.league) {
            isFetchingGames = false
            games = $0 ?? []
        }
    }
}

struct GamesListView_Previews: PreviewProvider {
    @State static var testSport: Sport? = Sport(league: "mlb",
                                                imageName: "baseball",
                                                activeImageName: "baseball_active")
    
    static var previews: some View {
        Group {
            GamesListView(sport: $testSport)
        }
    }
}
