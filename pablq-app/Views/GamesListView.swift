//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    let sport: Sport
    
    @State private var games: [Game] = [TestData.testGame]
    
    @State private var isFetchingGames = false
    
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
                    .font(.headline)
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
                    Text(sport.league.uppercased())
                        .font(.title)
                    ForEach(games) { game in
                        GameCell(game: game)
                    }
                }
                .padding([.top, .bottom])
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
