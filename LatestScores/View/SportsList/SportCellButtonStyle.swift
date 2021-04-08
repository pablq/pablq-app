//
//  SportCellButtonStyle.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/7/20.
//

import SwiftUI

struct SportCellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color(.accentAction) : Color(.background))
            .background(Color(.foreground))
            .cornerRadius(10.0)
            .shadow(
                color: Color(.background),
                radius: 5.0,
                x: 0,
                y: configuration.isPressed ? 4.0 : 8.0
            )
            .transformEffect(
                .init(
                    translationX: 0,
                    y: configuration.isPressed ? 0.0 : -4.0
                )
            )
            .animation(.default)
    }
}

struct SportCellButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(
            action: {},
            label: { Image(League.mlb.imageAsset) }
        )
        .buttonStyle(SportCellButtonStyle())
    }
}
