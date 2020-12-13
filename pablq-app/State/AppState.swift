//
//  AppState.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/7/20.
//

import Foundation

import UIKit

class AppAppearance {
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
    }
}

class AppState: ObservableObject {
    let allSports: [Sport] = [
        Sport(league: "mlb", imageName: "baseball"),
        Sport(league: "nhl", imageName: "hockey puck"),
        Sport(league: "nfl", imageName: "football"),
        Sport(league: "nba", imageName: "basketball")
    ]
    
    @Published var selectedSport: Sport? = nil
    
    @Published var games: [Game] = []
    
    @Published var isLoading: Bool = false
    
    @Published private(set) var teamName: String? = "chicago"
    
    private let httpClient = HttpClient()
    
    private let appAppearance = AppAppearance()
    
    func loadGames() {
        guard let league = selectedSport?.league else { return }
        isLoading = true
        httpClient.getGames(league: league) { [unowned self] in
            isLoading = false
            games = $0 ?? []
        }
    }
    
    func wakeup() {
        httpClient.wakeup()
    }
    
    func processDeepLink(url: URL) {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            if components.scheme == "pablq-widget" && components.host == "com.pablq.pablq-app.widget" {
                teamName = components.queryItems?.first { $0.name == "team-name" }?.value
                if let league = components.queryItems?.first(where: { $0.name == "league" })?.value {
                    selectedSport = allSports.first { $0.league == league }
                }
            }
        }
    }
}
