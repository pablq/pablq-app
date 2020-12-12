//
//  SportCell.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportCell: View {
    let sport: Sport
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Image(sport.imageName)
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
    static let testSport = Sport(league: "mlb", imageName: "baseball")
    
    static var previews: some View {
        Group {
            SportCell(sport: testSport, action: {})
        }
    }
}
