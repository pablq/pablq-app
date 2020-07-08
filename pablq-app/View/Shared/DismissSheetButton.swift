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
                .foregroundColor(Color.black)
        }
        .padding()
    }
}
