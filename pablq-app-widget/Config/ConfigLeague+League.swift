//
//  ConfigLeague+League.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

extension ConfigLeague {
    var league: League? {
        switch self {
        case .mlb: return .mlb
        case .nba: return .nba
        case .nfl: return .nfl
        case .nhl: return .nhl
        case .unknown: return nil
        }
    }
}
