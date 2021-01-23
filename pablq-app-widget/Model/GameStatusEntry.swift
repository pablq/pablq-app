//
//  GameStatusEntry.swift
//  pablq-app-widgetExtension
//
//  Created by Pablo Philipps on 1/23/21.
//

import WidgetKit

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
