//
//  ConfigNBATeam+StringValue.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

extension ConfigNBATeam {
    var stringValue: String? {
        switch self {
        case .celtics: return "boston"
        case .nets: return "brooklyn"
        case .knicks: return "new york"
        case .seventysixers: return "philadelphia"
        case .raptors: return "toronto"
        case .bulls: return "chicago"
        case .cavaliers: return "cleveland"
        case .pistons: return "detroit"
        case .pacers: return "indiana"
        case .bucks: return "milwaukee"
        case .hawks: return "atlanta"
        case .hornets: return "charlotte"
        case .heat: return "miami"
        case .magic: return "orlando"
        case .wizards: return "washington"
        case .nuggets: return "denver"
        case .timberwolves: return "minnesota"
        case .thunder: return "oklahoma city"
        case .trailblazers: return "portland"
        case .jazz: return "utah"
        case .warriors: return "golden state"
        case .clippers: return "la clippers"
        case .lakers: return "la lakers"
        case .suns: return "phoenix"
        case .kings: return "sacramento"
        case .mavericks: return "dallas"
        case .rockets: return "houston"
        case .grizzlies: return "memphis"
        case .pelicans: return "new orleans"
        case .spurs: return "san antonio"
        case .unknown: return nil
        }
    }
}
