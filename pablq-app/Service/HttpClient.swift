//
//  HttpClient.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/5/20.
//

import Foundation

class HttpClient {
    private let urlSession = URLSession.shared
    private let baseUrlString = "http://www.pablq.website"

    func getGames(league: String, callback: @escaping ([Game]?) -> Void) {
        let urlString = "\(baseUrlString)/sports/\(league)"
        guard let url = URL(string: urlString) else {
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
}
