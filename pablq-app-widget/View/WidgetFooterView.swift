//
//  WidgetFooterView.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import SwiftUI

struct WidgetFooterView: View {
    let configuration: ConfigurationIntent
    let lastUpdated: Date
    
    var body: some View {
        VStack {
            WidgetConfigurationDetailsView(configuration: configuration)
        }
    }
}
