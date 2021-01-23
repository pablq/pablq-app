//
//  pablq_appApp.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

@main
struct pablq_appApp: App {
    @Environment(\.scenePhase) private var scenePhase
    private let state = AppState()
    private let appearance = AppAppearance()
    
    var body: some Scene {
        WindowGroup {
            SportsListView(appState: state)
                .onOpenURL { state.dispatch(action: .appLaunchedWithDeepLink($0)) }
        }
        .onChange(of: scenePhase) {
            if $0 == .active {
                state.dispatch(action: .appBecameActive)
            }
        }
    }
}
