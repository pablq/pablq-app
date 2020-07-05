//
//  SportsListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListViewConfig {
    var presented: Bool
    var sport: Sport
}

struct SportsListView: View {
    
    private let sports: [Sport] = [
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
    
    private let link =  URL(string: "https://github.com/pablq/pablq-website")!
    
    @State private var selectedSport: Sport? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            List {
                Text(NSLocalizedString("SportsListViewTitle",
                                       value: "Latest Scores",
                                       comment: "The app fetches sports scores."))
                    .font(.title)
                    .padding([.top, .bottom])
                ForEach(sports) { sport in
                    HStack {
                        Spacer()
                        Image(selectedSport == sport ? sport.activeImageAssetName : sport.imageAssetName)
                        Spacer()
                    }
                    .padding(.all)
                    .onTapGesture {
                        selectedSport = sport
                    }
                }
                Link(destination: link) {
                    Text(link.relativeString).font(.footnote)
                }
            }
        }
        .sheet(item: $selectedSport) { _ in
            GamesListView(sport: $selectedSport)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SportsListView()
    }
}
