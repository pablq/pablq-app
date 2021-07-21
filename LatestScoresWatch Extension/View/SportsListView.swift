//
//  SportsListView.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/21/21.
//

import SwiftUI

struct SportsListView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        List {
            ForEach(appState.allLeagues) { sport in
                Button(
                    action: { appState.dispatch(action: .userSelectedLeague(sport)) },
                    label: {
                        HStack {
                            Spacer()
                            Text(sport.displayName)
                                .font(.headline)
                            Spacer()
                        }
                    }
                )
                .foregroundColor(Color(.foreground))
            }
        }
        .padding([.leading, .trailing], 10)
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
