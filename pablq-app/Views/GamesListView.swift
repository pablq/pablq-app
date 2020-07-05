//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    let sport: Sport
    
    @State private var games: [Game] = []
    
    @State private var isFetchingGames = true
    
    var body: some View {
        Group {
            if isFetchingGames {
                VStack {
                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                    Text(
                        NSLocalizedString("GamesListViewLoadingData",
                                          value: "Fetching games...",
                                          comment: "Placeholder to show user while fetching data from server.")
                    )
                    .font(.subheadline)
                }
                
            } else if (games.isEmpty) {
                Text(
                    NSLocalizedString("GamesListViewEmptyState",
                                      value: "Sorry, couldn't find any games today. :)",
                                      comment: "Shown when games data is not available.")
                )
                .font(.headline)
            } else {
                List {
                    ForEach(games) { game in
                        GameCell(game: game)
                    }
                }
            }
        }
        .onAppear { loadGames() }
    }
    
    func loadGames() {
        // TODO
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView(sport: TestData.testSport)
    }
}
