//
//  ContentView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedSport: Sport?
    
    var body: some View {
        VStack {
            List {
                ForEach(sports) { sport in
                    HStack {
                        Spacer()
                        Image(sport.imageAssetName)
                        Spacer()
                    }.onTapGesture {
                        selectedSport = sport
                    }
                }
                VStack {
                    Text("https://github.com/pablq/pablq-website")
                }
            }
        }.sheet(item: $selectedSport) { sport in
            GamesListView(sport: sport).onTapGesture {
                selectedSport = nil
            }
        }
    }
    
    private let sports: [Sport] = [
        Sport(name: "mlb", imageAssetName: "baseball"),
        Sport(name: "nhl", imageAssetName: "puck"),
        Sport(name: "nfl", imageAssetName: "football"),
        Sport(name: "nba", imageAssetName: "basketball")
    ]
}

struct Sport: Identifiable {
    var id = UUID()
    let name: String
    let imageAssetName: String
}

struct GamesListView: View {
    let sport: Sport
    
    var body: some View {
        Text(sport.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
