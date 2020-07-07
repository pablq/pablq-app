//
//  pablq_appApp.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

@main
struct pablq_appApp: App {
    private let sports = [
        Sport(league: "mlb",
              imageName: "baseball",
              activeImageName: "baseball_active"),
        Sport(league: "nhl",
              imageName: "puck",
              activeImageName: "puck_active"),
        Sport(league: "nfl",
              imageName: "football",
              activeImageName: "football_active"),
        Sport(league: "nba",
              imageName: "basketball",
              activeImageName: "basketball_active")
    ]
    
    var body: some Scene {
        WindowGroup {
            SportsListView(sports: sports)
        }
    }
}
