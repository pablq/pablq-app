//
//  SportCell.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import SwiftUI

struct SportCell: View {
    let sport: Sport
    let selected: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Image(selected ? sport.activeImageAssetName : sport.imageAssetName)
            Spacer()
        }
        .padding(.all)
    }
}

struct SportCell_Previews: PreviewProvider {
    static let testSport = Sport(league: "mlb",
                                 imageAssetName: "baseball",
                                 activeImageAssetName: "baseball_active")
    
    static var previews: some View {
        Group {
            SportCell(sport: testSport, selected: true)
            SportCell(sport: testSport, selected: false)
        }
    }
}
