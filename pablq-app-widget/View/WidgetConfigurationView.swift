//
//  WidgetConfigurationView.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import SwiftUI

struct WidgetConfigurationDetailsView: View {
    
    let configuration: ConfigurationIntent
    
    var body: some View {
        if let league = configuration.userFacingLeagueName,
           let teamName = configuration.userFacingTeamName {
            Text("\(league) - \(teamName)")
                .font(.footnote)
        } else {
            Text(
                NSLocalizedString(
                    "WidgetNotConfigured",
                    value: "Widget not configured.",
                    comment: "Shown when widget is not configured."
                )
            )
            .font(.footnote)
        }
    }
}
