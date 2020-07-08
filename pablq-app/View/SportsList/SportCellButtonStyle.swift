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
            .accentColor(.blue)
            .background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color.black,
                    radius: configuration.isPressed ? 10.0 : 25.0,
                    x: 0,
                    y: 15)
    }
}
