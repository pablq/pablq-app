//
//  League+LatestScores.swift
//  LatestScores
//
//  Created by Pablo Philipps on 4/7/21.
//

import Foundation

extension League: Identifiable {
    // swiftlint:disable:next identifier_name
    var id: League { return self }

    var imageAsset: ImageAsset {
        switch self {
        case .mlb:
            return .baseball
        case .nhl:
            return .hockeyPuck
        case .nfl:
            return .football
        case .nba:
            return .basketball
        }
    }
}
