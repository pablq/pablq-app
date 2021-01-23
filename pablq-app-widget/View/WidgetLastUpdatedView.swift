//
//  WidgetLastUpdatedView.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import SwiftUI

struct WidgetLastUpdatedView: View {
    let date: Date
    
    var body: some View {
        Text(date, style: .time)
            .font(.footnote)
            .fontWeight(.ultraLight)
    }
}
