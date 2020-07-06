//
//  pablq_appApp.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

@main
struct pablq_appApp: App {
    var body: some Scene {
        WindowGroup {
            SportsListView(sports: [
                Sport(league: "mlb",
                      imageAssetName: "baseball",
                      activeImageAssetName: "baseball_active"),
                Sport(league: "nhl",
                      imageAssetName: "puck",
                      activeImageAssetName: "puck_active"),
                Sport(league: "nfl",
                      imageAssetName: "football",
                      activeImageAssetName: "football_active"),
                Sport(league: "nba",
                      imageAssetName: "basketball",
                      activeImageAssetName: "basketball_active")
            ])
        }
    }
}
