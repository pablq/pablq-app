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
        GameStatusEntry(
            date: Date(),
            games: [],
            configuration: ConfigurationIntent())
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (GameStatusEntry) -> ()
    ) {
        
        if context.isPreview {
            let entry = GameStatusEntry(
                date: Date(),
                games: [],
                configuration: configuration
            )
            completion(entry)
        } else {
            HttpClient().getGames(league: "nfl") { games in
                let favorites = games?.filter { $0.isFavorite }
                let entry = GameStatusEntry(
                    date: Date(),
                    games: favorites ?? [],
                    configuration: configuration
                )
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
            let entry = GameStatusEntry(date: Date(),
                                        games: games,
                                        configuration: configuration)
    
            let nextRefresh: Date
            if (games.isEmpty || games.allSatisfy { $0.isOver }) {
                nextRefresh = getNext11amChicagoTime()
            } else if (games.contains { $0.isLive }) {
                nextRefresh = getDateAfter(minutes: 7)
            } else if configuration.league == "nfl" {
                if isNflGameday() {
                    nextRefresh = getDateAfter(minutes: 60)
                } else {
                    nextRefresh = getNext11amChicagoTime()
                }
            } else {
                nextRefresh = getDateAfter(minutes: 60)
            }
            
            let timeline = Timeline(entries: [entry],
                                    policy: .after(nextRefresh))
            completion(timeline)
        }
    }
    
    private func getDateAfter(minutes: Int) -> Date {
        return Date().addingTimeInterval(60 * Double(minutes))
    }
    
    private func getNext11amChicagoTime() -> Date {
        let now = Date()
        let dateComponents = calendar.dateComponents(in: chicagoStandardTime, from: now)
        if dateComponents.hour ?? 0 < 11 {
            return calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
        } else {
            let todayAt11 = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
            return calendar.date(byAdding: .day, value: 1, to: todayAt11)!
        }
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    private let chicagoStandardTime = TimeZone(abbreviation: "CST")!
    
    private func isNflGameday() -> Bool {
        let now = Date()
        let dateComponents = calendar.dateComponents(in: chicagoStandardTime, from: now)
        guard let dayOfWeek = dateComponents.weekday else {
            return false
        }
        return dayOfWeek == 1 || dayOfWeek == 5 || dayOfWeek == 7
    }
}

struct GameStatusEntry: TimelineEntry {
    let date: Date
    let games: [Game]
    let configuration: ConfigurationIntent
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
                HStack {
                    Text("Updated:")
                    Text(entry.date, style: .time)
                }
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct TeamWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamWidgetEntryView(
            entry:
                GameStatusEntry(
                    date: Date(),
                    games: [],
                    configuration: ConfigurationIntent()
                )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
