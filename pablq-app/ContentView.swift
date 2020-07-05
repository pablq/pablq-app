//
//  ContentView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct ContentView: View {
    
    private let sports: [Sport] = [
        Sport(name: "mlb", imageAssetName: "baseball", activeImageAssetName: "baseball_active"),
        Sport(name: "nhl", imageAssetName: "puck", activeImageAssetName: "puck_active"),
        Sport(name: "nfl", imageAssetName: "football", activeImageAssetName: "football_active"),
        Sport(name: "nba", imageAssetName: "basketball", activeImageAssetName: "basketball_active")
    ]
    
    private let links: [Link] = [
        Link(userFacingString: "https://github.com/pablq/pablq-website",
             url: URL(string: "https://github.com/pablq/pablq-website")),
        Link(userFacingString: "https://github.com/pablq/pablq-app",
             url: nil),
    ]
    
    @State var selectedSport: Sport?
    
    var body: some View {
        VStack(alignment: .center) {
            List {
                ForEach(sports) { sport in
                    HStack {
                        Spacer()
                        Image(
                            selectedSport?.id == sport.id ? sport.activeImageAssetName : sport.imageAssetName)
                        Spacer()
                    }
                    .padding(.all, 10)
                    .onTapGesture {
                        selectedSport = sport
                    }
                }
                ForEach(links) { link in
                    Button(action: {
                        if let url = link.url {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text(link.userFacingString).font(
                            .footnote)
                    })
                }
            }
        }.sheet(item: $selectedSport) { sport in
            GamesListView(sport: sport).onTapGesture {
                selectedSport = nil
            }
        }
    }
 }

struct Link: Identifiable {
    let id = UUID()
    let userFacingString: String
    let url: URL?
}

struct Sport: Identifiable {
    var id = UUID()
    let name: String
    let imageAssetName: String
    let activeImageAssetName: String
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
