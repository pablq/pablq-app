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
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                SheetHeaderView(title: appState.selectedLeague?.rawValue.uppercased()) {
                    appState.dispatch(action: .userDismissedLeague)
                }
                Spacer()
                Group {
                    if appState.isLoading {
                        LoadingView(
                            message: NSLocalizedString(
                                "GamesListViewLoading",
                                value: "Fetching games...",
                                comment: "Shown when games data is being fetched."
                            )
                        )
                    } else if appState.games.isEmpty {
                        EmptyStateView(
                            message: NSLocalizedString(
                                "GamesListViewEmptyState",
                                value: "No games today. :)",
                                comment: "Shown when games data is not available."
                            )
                        )
                    } else {
                        List {
                            ForEach(appState.games) { game in
                                GameCell(game: game, isFavorite: isFavorite(game: game))
                                    .listRowBackground(Color("background"))
                            }
                            .padding(10)
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
            }
            .foregroundColor(.white)
        }
        .onAppear { appState.dispatch(action: .gamesListAppeared) }
    }
    
    private func isFavorite(game: Game) -> Bool {
        guard let teamName = appState.teamName else { return false }
        return game.headline.lowercased().contains(teamName.lowercased())
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
            games = [
                Game(
                    headline: "Headline 0",
                    link: "http://www.google.com",
                    lines: ["line1", "line2"]
                ),
                Game(
                    headline: "Headline 1",
                    link: "http://www.google.com",
                    lines: ["line1", "line2", "line3"]
                ),
                Game(
                    headline: "Headline 3",
                    link: "http://www.google.com",
                    lines: []
                )
            ]
        }
        
        let appState = TestAppState()
        appState.setGames(games)
        appState.setIsLoading(isLoading)
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
