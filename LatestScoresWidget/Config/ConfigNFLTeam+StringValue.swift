//
//  ConfigNFLTeam+StringValue.swift
//  LatestScoresWidgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

extension ConfigNFLTeam {
    var stringValue: String? {
        switch self {
        case .bears: return "chicago"
        case .bengals: return "cincinnati"
        case .bills: return "buffalo"
        case .dolphins: return "miami"
        case .patriots: return "new england"
        case .jets: return "ny jets"
        case .ravens: return "baltimore"
        case .browns: return "cleveland"
        case .steelers: return "pittsburgh"
        case .texans: return "houston"
        case .colts: return "indianapolis"
        case .jaguars: return "jacksonville"
        case .titans: return "tennesee"
        case .broncos: return "denver"
        case .chiefs: return "kansas city"
        case .raiders: return "las vegas"
        case .chargers: return "la chargers"
        case .cowboys: return "dallas"
        case .giants: return "ny giants"
        case .eagles: return "philadelphia"
        case .wft: return "washington"
        case .lions: return "detroit"
        case .packers: return "green bay"
        case .vikings: return "minnesota"
        case .falcons: return "atlanta"
        case .panthers: return "carolina"
        case .saints: return "new orleans"
        case .buccaneers: return "tampa bay"
        case .cardinals: return "arizona"
        case .rams: return "la rams"
        case .fortyniners: return "san francisco"
        case .seahawks: return "seattle"
        case .unknown: return nil
        }
    }
}
