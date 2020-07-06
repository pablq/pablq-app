//
//  SportsListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportsListView: View {
    
    let sports: [Sport]
    
    @State private var selectedSport: Sport? = nil
    
    var body: some View {
        List {
            ListHeaderView(title: NSLocalizedString("SportsListViewTitle",
                                                    value: "Latest Scores",
                                                    comment: "The app fetches sports scores."))
            ForEach(sports) { sport in
                SportCell(sport: sport, selected: selectedSport == sport)
                    .onTapGesture {
                        selectedSport = sport
                    }
            }
            if let url = URL(string: "https://github.com/pablq/pablq-website") {
                Link(destination: url) {
                    Text(url.relativeString)
                        .font(.footnote)
                }
            }
        }
        .sheet(item: $selectedSport) { _ in
            GamesListView(sport: $selectedSport)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let testSports = [
        Sport(league: "mlb",
              imageAssetName: "baseball",
              activeImageAssetName: "baseball_active"),
        Sport(league: "nhl",
              imageAssetName: "puck",
              activeImageAssetName: "puck_active"),
        Sport(league: "nfl",
              imageAssetName: "football",
              activeImageAssetName: "football_active"),
        Sport(league: "nba",
              imageAssetName: "basketball",
              activeImageAssetName: "basketball_active")
    ]
    
    static var previews: some View {
        SportsListView(sports: testSports)
    }
}
