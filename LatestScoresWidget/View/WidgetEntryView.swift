//
//  WidgetEntryView.swift
//  LatestScoresWidgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import SwiftUI
import WidgetKit

struct WidgetEntryView: View {

    let entry: WidgetTimelineProvider.Entry

    var body: some View {
        ZStack {
            if let game = entry.mostRelevantGame {
                game.isLive ? Color(.accentOngoing) : Color(.background)
                VStack {
                    Spacer()
                    Text(game.headline)
                        .font(.headline)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    if !game.description.isEmpty && entry.sizeClass == .systemMedium {
                        Text(game.description)
                            .font(.body)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }
                    Spacer()
                    WidgetFooterView(
                        configuration: entry.configuration,
                        lastUpdated: entry.date
                    )
                }
                .padding()
                .foregroundColor(Color(.foreground))
                .widgetURL(entry.deepLinkUrl)
            } else {
                Color(.background)
                VStack {
                    Spacer()
                    Text(
                        NSLocalizedString(
                            "WidgetEmptyState",
                            value: "No games today. :)",
                            comment: "Shown when games data is not available."
                        )
                    )
                    .font(.body)
                    Spacer()
                    WidgetFooterView(
                        configuration: entry.configuration,
                        lastUpdated: entry.date
                    )
                }
                .padding()
                .foregroundColor(Color(.foreground))
                .widgetURL(entry.deepLinkUrl)
            }
        }
    }
}

struct TeamWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(
            entry:
                GameStatusEntry(
                    date: Date(),
                    games: [],
                    configuration: ConfigurationIntent(),
                    sizeClass: .systemSmall
                )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
