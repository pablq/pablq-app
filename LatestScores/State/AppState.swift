//
//  AppState.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/7/20.
//

import Foundation

class AppState: ObservableObject {
    let allLeagues = League.allCases

    @Published fileprivate(set) var selectedLeague: League?

    @Published fileprivate(set) var games: [Game] = []

    @Published fileprivate(set) var isLoading: Bool = false

    /// Do not set directly, always use `dispatch` to update state.
    @Published var isGamesListPresented: Bool = false

    func dispatch(action: AppAction) {
        switch action {
        case .appBecameActive:
            break
        case .appLaunchedWithDeepLink(let url):
            handleAppLaunchedWithDeepLink(url: url)
        case .gamesListAppeared:
            loadGames()
        case .userSelectedLeague(let league):
            selectedLeague = league
            isGamesListPresented = true
        case .userDismissedLeague:
            selectedLeague = nil
            isGamesListPresented = false
        }
    }

    init(httpClient: HttpClient = HttpClient()) {
        self.httpClient = httpClient
    }

    private let httpClient: HttpClient

    private func handleAppLaunchedWithDeepLink(url: URL) {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            if components.scheme == "pablq-widget" && components.host == "com.pablq.pablq-app.widget" {
                if let leagueString = components.queryItems?.first(where: { $0.name == "league"  })?.value,
                   let league = League(rawValue: leagueString) {
                    selectedLeague = league
                    if !isGamesListPresented {
                        isGamesListPresented = true
                    } else {
                        loadGames()
                    }
                }
            }
        }
    }

    private func loadGames() {
        guard let league = selectedLeague else { return }
        isLoading = true
        httpClient.getGames(league: league.rawValue) { [unowned self] in
            isLoading = false
            games = $0 ?? []
        }
    }
}

class TestAppState: AppState {
    func setSelectedSport(_ league: League?) {
        self.selectedLeague = league
    }

    func setGames(_ games: [Game]) {
        self.games = games
    }

    func setIsLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
}
