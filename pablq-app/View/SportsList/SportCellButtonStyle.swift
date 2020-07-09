//
//  SportCellButtonStyle.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/7/20.
//

import SwiftUI

struct SportCellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.red : Color.black)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(
                color: Color.black,
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
        Button(action: {}) {
            Image("baseball")
        }
        .buttonStyle(SportCellButtonStyle())
    }
}
