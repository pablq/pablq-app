//
//  TitleView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.title)
                .padding([.top, .bottom])
            Spacer()
        }
    }
}
