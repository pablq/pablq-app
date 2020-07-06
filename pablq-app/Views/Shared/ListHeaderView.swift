//
//  ListHeaderView.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import SwiftUI

struct ListHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .padding([.top, .bottom])
    }
}
