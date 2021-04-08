//
//  SportsListView.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportsListView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        ZStack {
            Color(.backgroundNeutral).edgesIgnoringSafeArea(.all)
            List {
                ForEach(appState.allLeagues) { sport in
                    SportCell(
                        league: sport,
                        action: { appState.dispatch(action: .userSelectedLeague(sport)) }
                    )
                    .listRowBackground(Color(.backgroundNeutral))
                    .padding([.leading, .trailing], 15.0)
                    .padding([.top, .bottom], 10.0)
                }
                .frame(height: 180.0)
            }
            .foregroundColor(Color(.foreground))
        }
        .sheet(isPresented: $appState.isGamesListPresented) {
            GamesListView(appState: appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SportsListView(appState: AppState())
    }
}
