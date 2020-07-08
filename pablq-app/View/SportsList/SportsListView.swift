//
//  SportsListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportsListView: View {
    
    @ObservedObject var appState: AppState
    
    var body: some View {
        List {
            TitleView(title: NSLocalizedString("SportsListViewTitle",
                                               value: "Latest Scores",
                                               comment: "The app fetches sports scores."))
            
            ForEach(appState.allSports) { sport in
                SportCell(sport: sport, action: { appState.selectedSport = sport })
                    .padding([.leading, .trailing], 15.0)
                    .padding([.top, .bottom], 10.0)
            }
            if let url = URL(string: "https://github.com/pablq/pablq-app") {
                Link(destination: url) {
                    Text(url.relativeString)
                        .font(.footnote)
                }
            }
        }
        .sheet(item: $appState.selectedSport) { _ in
            GamesListView(appState: appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SportsListView(appState: AppState())
    }
}
