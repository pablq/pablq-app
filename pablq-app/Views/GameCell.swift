//
//  GameCell.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GameCell: View {
    let game: Game
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text(game.headline)
                .font(.headline)
            Text(game.description).font(.body)
            if let url = game.url {
                Link(destination: url) {
                    Text(url.relativeString).font(.footnote)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameCell(game: TestData.testGame)
    }
}
