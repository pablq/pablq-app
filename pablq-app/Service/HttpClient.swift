//
//  HttpClient.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import Foundation

class HttpClient {
    private let urlSession = URLSession.shared
    private let kScheme = "http"
    private let kHost = "www.pablq.website"

    func getGames(league: String, callback: @escaping ([Game]?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = kScheme
        urlComponents.host = kHost
        urlComponents.path = "/sports/\(league)"
        guard let url = urlComponents.url else {
            callback(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            var games: [Game]? = nil
            defer {
                DispatchQueue.main.async {
                    callback(games)
                }
            }
            guard let data = data else { return }
            games = try? JSONDecoder().decode([Game].self, from: data)
        }.resume()
    }
    
    func getGames(league: String, teamName: String, callback: @escaping ([Game]?) -> Void) {
        let internalCallback: ([Game]?) -> Void = { games in
            let filtered = games?.filter { $0.headline.lowercased().contains(teamName.lowercased()) }
            callback(filtered)
        }
        getGames(league: league, callback: internalCallback)
    }
    
    func wakeup() {
        var urlComponents = URLComponents()
        urlComponents.scheme = kScheme
        urlComponents.host = kHost
        if let url = urlComponents.url {
            urlSession.dataTask(with: url).resume()
        }
    }
}
