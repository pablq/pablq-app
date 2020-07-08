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
        HStack {
            VStack(alignment: .leading, spacing: 10.0) {
                Text(game.headline)
                    .font(.headline)
                Text(game.description)
                    .font(.body)
                if let url = game.url {
                    Link(destination: url) {
                        Text(url.relativeString)
                            .font(.footnote)
                    }
                }
            }
            Spacer()
        }
        .padding(25.0)
        .background(Color.black)
        .foregroundColor(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(game.isFavorite ? Color.red : Color.gray,
                        lineWidth:  10)
        )
    }
}

struct GameView_Previews: PreviewProvider {
    static let testGame = Game(headline: "headline",
                               link: "http://www.pablq.website/",
                               lines: ["line 1", "line 2"])
    
    static var previews: some View {
        GameCell(game: testGame)
    }
}
