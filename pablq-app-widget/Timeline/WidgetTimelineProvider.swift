//
//  WidgetTimelineProvider.swift
//  pablq-app-widgetExtension
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
        completion: @escaping (GameStatusEntry) -> ()
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
    
    private let kNfl = "nfl"
    
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<GameStatusEntry>) -> ()
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
        let isSunday = dayOfWeek == 1
        let isMonday = dayOfWeek == 2
        let isThursday = dayOfWeek == 5
        let isSaturday = dayOfWeek == 7
        return isSunday || isMonday || isThursday || isSaturday
    }
}
