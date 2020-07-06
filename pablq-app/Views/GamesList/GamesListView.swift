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
            SheetViewHeader(dismissAction: dismiss)
            Spacer()
            Group {
                if isFetchingGames {
                    GamesListLoading()
                } else if let sport = sport,
                          !games.isEmpty {
                    GamesList(sport: sport, games: games)
                } else {
                    GamesListEmptyState()
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
        isFetchingGames = true
        guard let sport = sport else {
            isFetchingGames = false
            return
        }
        HttpClient().getGames(league: sport.league) {
            isFetchingGames = false
            games = $0 ?? []
        }
    }
}

struct SheetViewHeader: View {
    let dismissAction: () -> Void
    var body: some View {
        HStack {
            Spacer()
            Button(action: dismissAction) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black)
            }
            .padding([.top, .trailing])
        }
    }
}

struct GamesListLoading: View {
    var body: some View {
        VStack(spacing: 25.0) {
            ProgressView()
            Text(
                NSLocalizedString("GamesListViewLoading",
                                  value: "Fetching games...",
                                  comment: "Shown when games data is being fetched.")
            )
        }
    }
}

struct GamesListEmptyState: View {
    var body: some View {
        Text(
            NSLocalizedString("GamesListViewEmptyState",
                              value: "Sorry, couldn't find any games today. :)",
                              comment: "Shown when games data is not available.")
        )
    }
}

struct GamesList: View {
    let sport: Sport
    let games: [Game]
    
    var body: some View {
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

struct GamesListView_Previews: PreviewProvider {
    @State static var testSport: Sport? = TestData.testSport
    
    static var previews: some View {
        Group {
            GamesListView(sport: $testSport)
            GamesListView(sport: $testSport)
        }
    }
}
