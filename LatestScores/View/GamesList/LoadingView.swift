//
//  LoadingView.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/5/20.
//

import SwiftUI

struct LoadingView: View {
    let message: String?

    var body: some View {
        VStack(spacing: 25.0) {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color(.foreground))
                )
            if let message = message {
                Text(message)
            }
        }
        .padding()
        Spacer()
        Spacer()
        Spacer()
    }
}
