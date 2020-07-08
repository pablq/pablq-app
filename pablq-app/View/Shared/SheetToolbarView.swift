//
//  SheetHeaderView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import SwiftUI

struct SheetToolbarView: View {
    let dismissAction: () -> Void
    var body: some View {
        HStack {
            Spacer()
            Button(action: dismissAction) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black)
            }
            .padding([.top, .trailing])
        }
    }
}
