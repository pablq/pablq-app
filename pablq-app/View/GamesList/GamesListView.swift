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
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
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
                                    .listRowBackground(Color.clear)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear { appState.loadGames() }
    }
}

struct GamesListView_Previews: PreviewProvider {
    enum Mode {
        case empty
        case loading
        case data
    }
    
    static func getAppState(mode: Mode) -> AppState {
        var games: [Game] = []
        var isLoading: Bool = false
        switch mode {
        case .empty:
            break
        case .loading:
            isLoading = true
        case .data:
            games = [Game(headline: "Headline",
                          link: "http://www.google.com",
                          lines: ["line1", "line2"])]
        }
        
        let appState = AppState()
        appState.games = games
        appState.isLoading = isLoading
        return appState
    }
    
    static var previews: some View {
        Group {
            GamesListView(appState: getAppState(mode: .empty))
            GamesListView(appState: getAppState(mode: .loading))
            GamesListView(appState: getAppState(mode: .data))
        }
    }
}
