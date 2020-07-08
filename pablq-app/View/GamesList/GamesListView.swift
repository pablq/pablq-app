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
            SheetToolbarView() { appState.selectedSport = nil }
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
                        ListHeaderView(title: appState.selectedSport?.league ?? "")
                        ForEach(appState.games) { game in
                            GameCell(game: game)
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
    static var previews: some View {
        Group {
            GamesListView(appState: AppState())
        }
    }
}
