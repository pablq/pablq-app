//
//  FooterView.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/15/20.
//

import SwiftUI

struct FooterView: View {
    let url: URL

    var body: some View {
        HStack {
            Spacer()
            Link(destination: url) {
                Text(url.relativeString)
                    .font(.footnote)
            }
            Spacer()
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(url: URL(string: "http://www.pablq.website")!)
    }
}
