//
//  ConfigNHLTeam+StringValue.swift
//  LatestScoresWidgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

extension ConfigNHLTeam {
    var stringValue: String? {
        switch self {
        case .hurricanes: return "carolina"
        case .bluejackets: return "columbus"
        case .devils: return "new jersey"
        case .islanders: return "ny islanders"
        case .rangers: return "ny rangers"
        case .flyers: return "philadelphia"
        case .penguins: return "pittsburgh"
        case .capitals: return "washington"
        case .bruins: return "boston"
        case .sabres: return "buffalo"
        case .redwings: return "detroit"
        case .panthers: return "florida"
        case .canadiens: return "montreal"
        case .senators: return "ottawa"
        case .lightning: return "tampa bay"
        case .mapleleafs: return "toronto"
        case .blackhawks: return "chicago"
        case .avalanche: return "colorado"
        case .stars: return "dallas"
        case .wild: return "minnesota"
        case .predators: return "nashville"
        case .blues: return "st. louis"
        case .jets: return "winnipeg"
        case .ducks: return "anaheim"
        case .coyotes: return "arizona"
        case .flames: return "calgary"
        case .oilers: return "edmonton"
        case .kings: return "los angeles"
        case .sharks: return "san jose"
        case .canucks: return "vancouver"
        case .goldenknights: return "las vegas"
        case .unknown: return nil
        }
    }
}
