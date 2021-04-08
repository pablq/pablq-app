//
//  WidgetTimelineProvider.swift
//  LatestScoresWidgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import WidgetKit
import Intents

struct WidgetTimelineProvider: IntentTimelineProvider {

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
        completion: @escaping (GameStatusEntry) -> Void
    ) {
        guard let league = configuration.leagueStringValue,
              let teamName = configuration.teamStringValue,
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

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<GameStatusEntry>) -> Void
    ) {
        guard let league = configuration.leagueStringValue,
              let teamName = configuration.teamStringValue else {
            let entry = Entry(
                date: Date(),
                games: [],
                configuration: configuration,
                sizeClass: context.family
            )
            completion(
                Timeline(
                    entries: [entry],
                    policy: .after(getNextDefaultUpdate())
                )
            )
            return
        }

        HttpClient().getGames(league: league, teamName: teamName) { result in
            guard let games = result else {
                let tryAgainTimeline = Timeline(
                    entries: [] as [GameStatusEntry],
                    policy: .after(getDateAfter(minutes: 60))
                )
                completion(tryAgainTimeline)
                return
            }
            let nextRefresh: Date
            if (games.isEmpty || games.allSatisfy { $0.isOver }) {
                nextRefresh = getNextDefaultUpdate()
            } else if (games.contains { $0.isLive }) {
                nextRefresh = getDateAfter(minutes: 7)
            } else if configuration.league == .nfl {
                if isNflGameday() {
                    nextRefresh = getDateAfter(minutes: 60)
                } else {
                    nextRefresh = getNextDefaultUpdate()
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
            let timeline = Timeline(
                entries: [entry],
                policy: .after(nextRefresh)
            )
            completion(timeline)
        }
    }

    private func getDateAfter(minutes: Int) -> Date {
        return Date().addingTimeInterval(60 * Double(minutes))
    }

    private static let kCalendar = Calendar(identifier: .gregorian)
    private static let kChicagoStandardTime = TimeZone(abbreviation: "CST")!

    private func getNextDefaultUpdate(
        calendar: Calendar = kCalendar,
        timeZone: TimeZone = kChicagoStandardTime,
        hourOfFirstUpdate: Int = 11
    ) -> Date {
        let now = Date()
        let dateComponents = calendar.dateComponents(in: timeZone, from: now)
        if dateComponents.hour ?? 0 < hourOfFirstUpdate {
            return calendar.date(bySettingHour: hourOfFirstUpdate, minute: 0, second: 0, of: now)!
        } else {
            let todayAtHour = calendar.date(bySettingHour: hourOfFirstUpdate, minute: 0, second: 0, of: now)!
            return calendar.date(byAdding: .day, value: 1, to: todayAtHour)!
        }
    }

    private func isNflGameday(
        calendar: Calendar = kCalendar,
        timeZone: TimeZone = kChicagoStandardTime
    ) -> Bool {
        let now = Date()
        let dateComponents = calendar.dateComponents(in: timeZone, from: now)
        guard let dayOfWeek = dateComponents.weekday else {
            return false
        }
        let isSunday = dayOfWeek == 1
        let isMonday = dayOfWeek == 2
        let isThursday = dayOfWeek == 5
        let isSaturday = dayOfWeek == 7
        return isSunday || isMonday || isThursday || isSaturday
    }
}
