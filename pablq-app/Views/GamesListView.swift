//
//  GamesListView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GamesListView: View {
    let sport: Sport
    
    var body: some View {
        Text(sport.name)
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView(
            sport: Sport(name: "mlb", imageAssetName: "baseball", activeImageAssetName: "baseball_active")
        )
    }
}
