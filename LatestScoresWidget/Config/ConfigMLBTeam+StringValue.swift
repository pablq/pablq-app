//
//  ConfigMLBTeam+StringValue.swift
//  LatestScoresWidgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

extension ConfigMLBTeam {
    var stringValue: String? {
        switch self {
        case .braves: return "atlanta"
        case .marlins: return "miami"
        case .mets: return "ny mets"
        case .phillies: return "philadelphia"
        case .nats: return "washington"
        case .cubs: return "chicago cubs"
        case .reds: return "cincinnati"
        case .brewers: return "milwaukee"
        case .pirates: return "pittsburgh"
        case .cards: return "st. louis"
        case .diamondbacks: return "arizona"
        case .rockies: return "colorado"
        case .dodgers: return "la dodgers"
        case .padres: return "san diego"
        case .giants: return "san francisco"
        case .orioles: return "baltimore"
        case .redsox: return "boston"
        case .yankees: return "ny yankees"
        case .rays: return "tampa"
        case .bluejays: return "toronto"
        case .whitesox: return "chicago sox"
        case .indians: return "cleveland"
        case .tigers: return "detroit"
        case .royals: return "kansas city"
        case .twins: return "minnesota"
        case .astros: return "houston"
        case .angels: return "la angels"
        case .athletics: return "oakland"
        case .mariners: return "seattle"
        case .rangers: return "texas"
        case .unknown: return nil
        }
    }
}
