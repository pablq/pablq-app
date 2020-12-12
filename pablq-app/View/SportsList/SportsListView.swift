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
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            List {
                TitleView(
                    title:
                        NSLocalizedString(
                            "SportsListViewTitle",
                            value: "Latest Scores",
                            comment: "The app fetches sports scores."
                        )
                )
                .listRowBackground(Color.gray)
                
                ForEach(appState.allSports) { sport in
                    SportCell(
                        sport: sport,
                        action: { appState.selectedSport = sport }
                    )
                    .listRowBackground(Color.gray)
                    .padding([.leading, .trailing], 15.0)
                    .padding([.top, .bottom], 10.0)
                }
                .frame(height: 180.0)
                if let url = URL(string: "https://github.com/pablq/pablq-app") {
                    FooterView(url: url)
                        .listRowBackground(Color.gray)
                }
            }
            .foregroundColor(.white)
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
