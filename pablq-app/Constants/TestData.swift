//
//  TestData.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

enum TestData {
    static let testSport = Sport(league: "mlb",
                                 imageAssetName: "baseball",
                                 activeImageAssetName: "baseball_active")
    static let testGame = Game(headline: "headline", link: "http://www.pablq.website/", lines: ["line 1", "line 2"])
    static let testSports = [
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
    ]
}


