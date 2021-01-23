//
//  pablqAppWidget.swift
//  team-widget
//
//  Created by Pablo Philipps on 12/12/20.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct PablqAppWidget: Widget {
    let kind: String = "team_widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: WidgetTimelineProvider()
        ) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName(
            NSLocalizedString(
                "WidgetConfigurationDisplayName",
                value: "Latest Scores Widget",
                comment: "Title that what the widget does."
            )
        )
        .description(
            NSLocalizedString(
                "WidgetConfigurationDescription",
                value: "See today's scores from your favorite team.",
                comment: "Description of what the widget does."
            )
        )
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
