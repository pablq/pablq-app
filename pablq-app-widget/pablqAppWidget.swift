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
    
    private let kCalendar = Calendar(identifier: .gregorian)
    private let kChicagoStandardTime = TimeZone(abbreviation: "CST")!
    private let kNfl = "nfl"
    private let kExampleGame = Game(
        headline: "Houston at Chicago (1:00 PM ET)",
        link: "",
        lines: []
    )
    
    func placeholder(in context: Context) -> GameStatusEntry {
        return GameStatusEntry(
            date: Date(),
            games: [kExampleGame],
            configuration: ConfigurationIntent()
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
                configuration: configuration
            )
            completion(entry)
            return
        }

        HttpClient().getGames(league: league, teamName: teamName) { result in
            let entry = GameStatusEntry(
                date: Date(),
                games: result ?? [],
                configuration: configuration
            )
            completion(entry)
        }
    }

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
                configuration: configuration
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
            
            let entry = GameStatusEntry(date: Date(),
                                        games: games,
                                        configuration: configuration)
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
    
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            if let game = entry.games.first {
                game.isLive ? Color("accent-ongoing") : Color("background")
                VStack {
                    Spacer()
                    Text(game.headline)
                        .font(.headline)
                    if (!game.description.isEmpty) {
                        Text(game.description)
                            .font(.body)
                    }
                    Spacer()
                    WidgetDetailsFooterView(configuration: entry.configuration)
                }
                .padding()
                .foregroundColor(Color("foreground"))
                .widgetURL(entry.deepLinkUrl)
            } else {
                Color("background")
                VStack {
                    Spacer()
                    Text("No games today. :)")
                        .font(.body)
                    Spacer()
                    WidgetDetailsFooterView(configuration: entry.configuration)
                }
                .padding()
                .foregroundColor(Color("foreground"))
                .widgetURL(entry.deepLinkUrl)
            }
        }
    }
}

struct WidgetDetailsFooterView: View {
    
    let configuration: ConfigurationIntent
    
    var body: some View {
        if let league = configuration.league,
           let teamName = configuration.teamName {
                Text("\(league.uppercased()) - \(teamName)")
                    .font(.footnote)
        } else {
            Text("Widget not configured.")
                .font(.title)
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
        .configurationDisplayName("Latest Scores Widget")
        .description("See today's scores from your favorite team.")
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
