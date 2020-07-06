//
//  Game.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Game: Identifiable {
    var isFavorite: Bool {
        return headline.lowercased().contains("chicago")
    }
    
    var description: String {
        return lines.joined(separator: "\n")
    }
    
    var url: URL? {
        return URL(string: link)
    }
    
    let headline: String
    
    let id = UUID()
    private let link: String
    private let lines: [String]
    
    init?(from json: [String: Any]) {
        guard let headline = json["headline"] as? String,
              let lineCount = json["lineCount"] as? Int,
              let link = json["link"] as? String else {
            return nil
        }
        self.headline = headline
        self.link = link
        self.lines = (1...lineCount).reduce([]) { accum, next in
            if let line = json["p\(next)"] as? String {
                return accum + [line]
            } else {
                return accum
            }
        }
    }
    
    init(headline: String, link: String, lines: [String]) {
        self.headline = headline
        self.link = link
        self.lines = lines
    }
}
