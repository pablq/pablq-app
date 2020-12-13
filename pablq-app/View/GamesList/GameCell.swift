//
//  GameCell.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct GameCell: View {
    let game: Game
    let isFavorite: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(game.headline)
                    .font(.headline)
                Spacer()
            }
            if (!game.description.isEmpty) {
                Text(game.description)
                    .font(.body)
            }
            Spacer()
            if let url = game.url {
                Link(destination: url) {
                    Text(getLinkText())
                        .font(.footnote)
                }
            }
        }
        .padding()
        .foregroundColor(Color("foreground"))
        .background(isFavorite ? Color("background-special") : Color("background"))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    getStroke(),
                    lineWidth:  7
                )
        )
    }
    
    private func getLinkText() -> String {
        if game.isUpcoming { return "See preview" }
        return "See box score"
    }
    
    private func getStroke() -> Color {
        if game.isLive { return Color("accent-ongoing") }
        if game.isUpcoming { return Color("accent-upcoming") }
        return Color("accent-past")
    }
}

struct GameView_Previews: PreviewProvider {
    static let testGame = Game(
        headline: "headline",
        link: "http://www.pablq.website/",
        lines: ["line 1", "line 2"]
    )
    
    static var previews: some View {
        GameCell(game: testGame, isFavorite: true)
    }
}
