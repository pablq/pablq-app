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
    
    let sports: [Sport]
    
    private let link =  URL(string: "https://github.com/pablq/pablq-website")!
    
    @State private var selectedSport: Sport? = nil
    
    var body: some View {
        VStack(alignment: .center) {
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

struct ListHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .padding([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SportsListView(sports: TestData.testSports)
    }
}
