//
//  SportCell.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportCell: View {
    let league: League
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Image(league.imageAsset)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            .padding(25.0)
        }
        .buttonStyle(SportCellButtonStyle())
    }
}

struct SportCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SportCell(league: .mlb, action: {})
        }
    }
}
