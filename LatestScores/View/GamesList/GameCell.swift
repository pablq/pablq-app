//
//  GameCell.swift
//  LatestScores
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
            if !game.description.isEmpty {
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
        .foregroundColor(Color(.foreground))
        .background(isFavorite ? Color(.backgroundSpecial) : Color(.background))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    getStroke(),
                    lineWidth: 7
                )
        )
    }

    private func getLinkText() -> String {
        if game.isUpcoming { return String.seePreview }
        return String.seeBoxScore
    }

    private func getStroke() -> Color {
        if game.isLive { return Color(.accentOngoing) }
        if game.isUpcoming { return Color(.accentUpcoming) }
        return Color(.accentPast)
    }
}

// MARK: - Strings

fileprivate extension String {
    static let seePreview = NSLocalizedString("gameCellPreviewText", value: "See preview", comment: "")
    static let seeBoxScore = NSLocalizedString("gameCellBoxScoreText", value: "See box score", comment: "")
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
