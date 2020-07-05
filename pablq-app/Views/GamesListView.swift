//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    @Binding var sport: Sport?
    
    @State private var games: [Game] = [TestData.testGame]
    
    @State private var isFetchingGames = true
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: dismiss) {
                    Text("Close")
                }.padding([.top, .trailing])
            }
            Spacer()
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
                        if let sport = sport {
                            Text(sport.league.uppercased())
                                .font(.title)
                                .padding([.top, .bottom])
                        }
                        ForEach(games) { game in
                            GameCell(game: game)
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear { loadGames() }
    }
    
    func dismiss() {
        sport = nil
    }
    
    func loadGames() {
        // TODO
    }
}

struct GamesListView_Previews: PreviewProvider {
    @State static var testSport: Sport? = TestData.testSport
    
    static var previews: some View {
        Group {
            GamesListView(sport: $testSport)
            GamesListView(sport: $testSport)
        }
    }
}
