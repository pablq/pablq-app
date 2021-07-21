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

    var displayName: String {
        switch self {
        case .mlb:
            return String.mlbDisplayName
        case .nhl:
            return String.nhlDisplayName
        case .nfl:
            return String.nflDisplayName
        case .nba:
            return String.nbaDisplayName
        }
    }
}

// MARK: - Strings

fileprivate extension String {
    static let mlbDisplayName = NSLocalizedString(
        "mlbDisplayName",
        value: "Baseball",
        comment: "The name of the sport."
    )

    static let nhlDisplayName = NSLocalizedString(
        "nhlDisplayName",
        value: "Hockey",
        comment: "The name of the sport."
    )

    static let nflDisplayName = NSLocalizedString(
        "nflDisplayName",
        value: "Football",
        comment: "The name of the sport."
    )

    static let nbaDisplayName = NSLocalizedString(
        "nbaDisplayName",
        value: "Basketball",
        comment: "The name of the sport."
    )
}
