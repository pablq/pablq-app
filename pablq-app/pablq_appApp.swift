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
    
    var body: some Scene {
        WindowGroup {
            SportsListView(appState: state)
        }
        .onChange(of: scenePhase) {
            if $0 == .active {
                state.wakeup()
            }
        }
    }
}
