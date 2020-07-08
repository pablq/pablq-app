//
//  SheetHeaderView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import SwiftUI

struct SheetHeaderView: View {
    let title: String?
    let dismissAction: () -> Void
    var body: some View {
        ZStack {
            if let title = title {
                TitleView(title: title)
            }
            HStack {
                Spacer()
                Button(action: dismissAction) {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .foregroundColor(Color.black)
                }
                .padding()
            }
        }
    }
}
