//
//  Assets.swift
//  LatestScores
//
//  Created by Pablo Philipps on 4/7/21.
//

import Foundation

enum ColorAsset: String {
    case accentAction = "accent-action"
    case accentOngoing = "accent-ongoing"
    case accentPast = "accent-past"
    case accentUpcoming = "accent-upcoming"
    case backgroundNeutral = "background-neutral"
    case backgroundSpecial = "background-special"
    case background
    case foreground
}

enum ImageAsset: String {
    case baseball
    case basketball
    case football
    case hockeyPuck = "hockey puck"
    case xmark

    var isSystemImage: Bool {
        return self == .xmark
    }
}
