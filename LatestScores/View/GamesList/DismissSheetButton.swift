//
//  DismissSheetButton.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/7/20.
//

import SwiftUI

struct DismissSheetButton: View {
    let dismissAction: () -> Void

    var body: some View {
        Button(action: dismissAction) {
            Image(.xmark)
                .renderingMode(.template)
                .accessibility(label: Text(String.dismiss))
        }
        .padding()
    }
}

// MARK: - Strings

fileprivate extension String {
    static let dismiss = NSLocalizedString(
        "dismissSheetButtonAccessibilityLabel",
        value: "Dismiss",
        comment: "Describes the purpose of the dismiss sheet button"
    )
}
