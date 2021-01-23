//
//  League.swift
//  pablq-app
//
//  Created by Pablo Philipps on 1/23/21.
//

import Foundation

enum League: String, Identifiable, CaseIterable {
    case nhl
    case mlb
    case nba
    case nfl
    
    var id: League { return self }
    
    var imageName: String {
        switch self {
        case .mlb:
            return "baseball"
        case .nhl:
            return "hockey puck"
        case .nfl:
            return "football"
        case .nba:
            return "basketball"
        }
    }
}
