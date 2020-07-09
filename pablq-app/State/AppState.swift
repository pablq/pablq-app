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
        Sport(league: "nhl", imageName: "puck"),
        Sport(league: "nfl", imageName: "football"),
        Sport(league: "nba", imageName: "basketball")
    ]
    
    @Published var selectedSport: Sport? = nil
    
    @Published var games: [Game] = []
    
    @Published var isLoading: Bool = true
    
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
}
