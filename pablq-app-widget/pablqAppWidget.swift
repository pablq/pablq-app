//
//  pablqAppWidget.swift
//  team-widget
//
//  Created by Pablo Philipps on 12/12/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    private let kExampleGame = Game(
        headline: "Houston at Chicago (1:00 PM ET)",
        link: "",
        lines: []
    )
    
    func placeholder(in context: Context) -> GameStatusEntry {
        return GameStatusEntry(
            date: Date(),
            games: [kExampleGame],
            configuration: ConfigurationIntent(),
            sizeClass: context.family
        )
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (GameStatusEntry) -> ()
    ) {
        guard let league = configuration.league?.lowercased(),
              let teamName = configuration.teamName,
              !context.isPreview else {
            let entry = GameStatusEntry(
                date: Date(),
                games: [kExampleGame],
                configuration: configuration,
                sizeClass: context.family
            )
            completion(entry)
            return
        }

        HttpClient().getGames(league: league, teamName: teamName) { result in
            let entry = GameStatusEntry(
                date: Date(),
                games: result ?? [],
                configuration: configuration,
                sizeClass: context.family
            )
            completion(entry)
        }
    }
    
    private let kNfl = "nfl"

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        guard let league = configuration.league?.lowercased(),
              let teamName = configuration.teamName else {
            let entry = Entry(
                date: Date(),
                games: [],
                configuration: configuration,
                sizeClass: context.family
            )
            completion(
                Timeline(
                    entries: [entry],
                    policy: .after(getNext11amChicagoTime())
                )
            )
            return
        }
        HttpClient().getGames(league: league, teamName: teamName) { result in
            let games = result ?? []
            let nextRefresh: Date
            if (games.isEmpty || games.allSatisfy { $0.isOver }) {
                nextRefresh = getNext11amChicagoTime()
            } else if (games.contains { $0.isLive }) {
                nextRefresh = getDateAfter(minutes: 7)
            } else if league == kNfl {
                if isNflGameday() {
                    nextRefresh = getDateAfter(minutes: 60)
                } else {
                    nextRefresh = getNext11amChicagoTime()
                }
            } else {
                nextRefresh = getDateAfter(minutes: 60)
            }
            
            let entry = GameStatusEntry(
                date: Date(),
                games: games,
                configuration: configuration,
                sizeClass: context.family
            )
            let timeline = Timeline(entries: [entry],
                                    policy: .after(nextRefresh))
            completion(timeline)
        }
    }
    
    private func getDateAfter(minutes: Int) -> Date {
        return Date().addingTimeInterval(60 * Double(minutes))
    }
    
    private let kCalendar = Calendar(identifier: .gregorian)
    private let kChicagoStandardTime = TimeZone(abbreviation: "CST")!
    
    private func getNext11amChicagoTime() -> Date {
        let now = Date()
        let dateComponents = kCalendar.dateComponents(in: kChicagoStandardTime, from: now)
        if dateComponents.hour ?? 0 < 11 {
            return kCalendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
        } else {
            let todayAt11 = kCalendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
            return kCalendar.date(byAdding: .day, value: 1, to: todayAt11)!
        }
    }
    
    private func isNflGameday() -> Bool {
        let now = Date()
        let dateComponents = kCalendar.dateComponents(in: kChicagoStandardTime, from: now)
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
    let sizeClass: WidgetFamily
    
    var mostRelevantGame: Game? {
        return games.first { $0.isLive } ??
            games.first { $0.isUpcoming } ??
            games.first
    }
    
    var deepLinkUrl: URL? {
        guard let league = configuration.league?.lowercased(),
              let teamName = configuration.teamName else {
            return nil
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "pablq-widget"
        urlComponents.host = "com.pablq.pablq-app.widget"
        let queryItems = [
            URLQueryItem(name: "league", value: league),
            URLQueryItem(name: "team-name", value: teamName)
        ]
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

struct TeamWidgetEntryView : View {
    
    let entry: Provider.Entry

    var body: some View {
        ZStack {
            if let game = entry.mostRelevantGame {
                game.isLive ? Color("accent-ongoing") : Color("background")
                VStack {
                    Spacer()
                    Text(game.headline)
                        .font(.headline)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    if (!game.description.isEmpty && entry.sizeClass == .systemMedium) {
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
                .foregroundColor(Color("foreground"))
                .widgetURL(entry.deepLinkUrl)
            } else {
                Color("background")
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
                .foregroundColor(Color("foreground"))
                .widgetURL(entry.deepLinkUrl)
            }
        }
    }
}

struct WidgetFooterView: View {
    let configuration: ConfigurationIntent
    let lastUpdated: Date
    
    var body: some View {
        VStack {
            WidgetConfigurationDetailsView(configuration: configuration)
            WidgetLastUpdatedView(date: lastUpdated)
        }
    }
}

struct WidgetConfigurationDetailsView: View {
    
    let configuration: ConfigurationIntent
    
    var body: some View {
        if let league = configuration.league,
           let teamName = configuration.teamName {
                Text("\(league.uppercased()) - \(teamName)")
                    .font(.footnote)
        } else {
            Text(
                NSLocalizedString(
                    "WidgetNotConfigured",
                    value: "Widget not configured.",
                    comment: "Shown when widget is not configured."
                )
            )
            .font(.title)
        }
    }
}

struct WidgetLastUpdatedView: View {
    let date: Date
    
    var body: some View {
        Text(date, style: .time)
            .font(.footnote)
            .fontWeight(.ultraLight)
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

struct TeamWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamWidgetEntryView(
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
