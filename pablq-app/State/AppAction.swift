//
//  AppAction.swift
//  pablq-app
//
//  Created by Pablo Philipps on 1/23/21.
//

import Foundation

enum AppAction {
    case appBecameActive
    case appLaunchedWithDeepLink(URL)
    case gamesListAppeared
    case userSelectedLeague(League)
    case userDismissedLeague
}
