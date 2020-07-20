//
//  DismissSheetButton.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/7/20.
//

import SwiftUI

struct DismissSheetButton: View {
    let dismissAction: () -> Void
    
    var body: some View {
        Button(action: dismissAction) {
            Image(systemName: "xmark")
                .renderingMode(.template)
                .accessibility(label:
                    Text(
                        NSLocalizedString(
                            "dismissSheetButtonAccessibilityLabel",
                            value: "Dismiss",
                            comment: "Describes the purpose of the dismiss sheet button"
                        )
                    )
                )
        }
        .padding()
    }
}
