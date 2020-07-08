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
                Image(sport.imageName).renderingMode(.template)
                Spacer()
            }
            .padding(25.0)
        }.buttonStyle(SportCellButtonStyle())
    }
}

struct SportCellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.red : Color.black)
            .accentColor(.blue)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color.black,
                    radius: configuration.isPressed ? 10.0 : 20.0,
                    x: 0,
                    y: 15)
    }
}

struct SportCell_Previews: PreviewProvider {
    static let testSport = Sport(league: "mlb",
                                 imageName: "baseball",
                                 activeImageName: "baseball_active")
    
    static var previews: some View {
        Group {
            SportCell(sport: testSport, action: {})
            SportCell(sport: testSport, action: {})
        }
    }
}
