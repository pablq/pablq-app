//
//  GamesListView.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/21/21.
//

import SwiftUI

struct GamesListView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        ZStack {
            Color(.background).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Group {
                    if appState.isLoading {
                        LoadingView(message: String.fetchingGames)
                    } else if appState.games.isEmpty {
                        EmptyStateView(message: String.noGamesToday)
                    } else {
                        List {
                            ForEach(appState.games) { game in
                                GameCell(
                                    game: game,
                                    isFavorite: false,
                                    showLink: false
                                )
                                .listRowBackground(Color(.background))
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .foregroundColor(Color(.foreground))
        }
        .onAppear { appState.dispatch(action: .gamesListAppeared) }
    }
}

// MARK: - Strings

fileprivate extension String {
    static let fetchingGames = NSLocalizedString(
        "GamesListViewLoading",
        value: "Fetching games...",
        comment: "Shown when games data is being fetched."
    )

    static let noGamesToday = NSLocalizedString(
        "GamesListViewEmptyState",
        value: "No games today. :)",
        comment: "Shown when games data is not available."
    )
}

// MARK: - Previews

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
            games = (0...10).map {
                Game(
                    headline: "Headline \($0)",
                    link: "http://www.google.com",
                    lines: ["line1", "line2"]
                )
            }
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
