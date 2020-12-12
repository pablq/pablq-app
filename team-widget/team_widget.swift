//
//  team_widget.swift
//  team-widget
//
//  Created by Pablo Philipps on 12/12/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> GameStatusEntry {
        GameStatusEntry(games: [],
                        configuration: ConfigurationIntent())
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (GameStatusEntry) -> ()
    ) {
        
        if context.isPreview {
            let entry = GameStatusEntry(games: [], configuration: configuration)
            completion(entry)
        } else {
            HttpClient().getGames(league: "nfl") { games in
                let favorites = games?.filter { $0.isFavorite }
                let entry = GameStatusEntry(games: favorites ?? [],
                                            configuration: configuration)
                completion(entry)
            }
        }
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        HttpClient().getGames(league: "nfl") { games in
            let games = games?.filter { $0.isFavorite } ?? []
            let entry = GameStatusEntry(games: games,
                                        configuration: configuration)
            let fifteenMinutesFromNow = Date().addingTimeInterval(60 * 15)
            let timeline = Timeline(entries: [entry],
                                    policy: .after(fifteenMinutesFromNow))
            completion(timeline)
        }
    }
}

struct GameStatusEntry: TimelineEntry {
    let date: Date = Date().addingTimeInterval(-60 * 60)
    let games: [Game]
    let configuration: ConfigurationIntent
    
    var elapsedTimeSinceUpdate: DateInterval {
        return DateInterval(start: date, end: Date())
    }
}

struct TeamWidgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        if entry.games.isEmpty {
            Text("No games")
        } else {
            VStack {
                Spacer()
                Text(entry.games.first!.headline)
                Spacer()
                Text(entry.elapsedTimeSinceUpdate)
                Spacer()
            }
        }
    }
}

@main
struct TeamWidget: Widget {
    let kind: String = "team_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            TeamWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TeamWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamWidgetEntryView(
            entry:
                GameStatusEntry(games: [], configuration: ConfigurationIntent())
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
