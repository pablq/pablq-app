//
//  ConfigurationIntent+StringValues.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import Foundation

extension ConfigurationIntent {
    var leagueStringValue: String? {
        return league.league?.rawValue
    }
    
    var teamStringValue: String? {
        switch league {
        case .mlb: return mlbTeam.stringValue
        case .nhl: return nhlTeam.stringValue
        case .nba: return nbaTeam.stringValue
        case .nfl: return nflTeam.stringValue
        case .unknown: return nil
        }
    }
    
    var userFacingTeamName: String? {
        guard let stringValue = teamStringValue else { return nil }
        var splitName = stringValue.split(separator: " ")
        if splitName.count <= 1 || splitName.first?.count != 2 {
            return stringValue.capitalized
        }
        return ([splitName.removeFirst().uppercased()] + splitName.map({ $0.capitalized })).joined(separator: " ")
    }
    
    var userFacingLeagueName: String? {
        return leagueStringValue?.uppercased()
    }
}
