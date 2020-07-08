//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack {
            SheetHeaderView(title: appState.selectedSport?.league.uppercased()) {
                appState.selectedSport = nil
            }
            Spacer()
            Group {
                if appState.isLoading {
                    LoadingView(message: NSLocalizedString("GamesListViewLoading",
                                                           value: "Fetching games...",
                                                           comment: "Shown when games data is being fetched."))
                    
                } else if appState.games.isEmpty {
                    EmptyStateView(message: NSLocalizedString("GamesListViewEmptyState",
                                                              value: "Sorry, couldn't find any games today. :)",
                                                              comment: "Shown when games data is not available."))
                } else {
                    List {
                        ForEach(appState.games) { game in
                            GameCell(game: game)
                                .cornerRadius(10.0)
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear { appState.loadGames() }
    }
}

struct GamesListView_Previews: PreviewProvider {
    
    static func getAppState() -> AppState {
        let appState = AppState()
        appState.games = [Game(headline: "Headline", link: "http://www.google.com", lines: ["line1", "line2"])]
        return appState
    }
    
    static var previews: some View {
        Group {
            GamesListView(appState: getAppState())
        }
    }
}
