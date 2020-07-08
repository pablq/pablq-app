//
//  Game.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Game: Identifiable, Decodable {
    let id: UUID
    let headline: String
    private let link: String
    private let lines: [String]
    
    var isFavorite: Bool {
        return headline.lowercased().contains("chicago")
    }
    
    var description: String {
        return lines.joined(separator: "\n")
    }
    
    var url: URL? {
        return URL(string: link)
    }
    
    init(from decoder: Decoder) throws {
        id = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headline = try values.decode(String.self, forKey: .headline)
        link = try values.decode(String.self, forKey: .link)
        let lineCount = try values.decode(Int.self, forKey: .lineCount)
        lines = try CodingKeys.lineKeys(lineCount: lineCount).map { try values.decode(String.self, forKey: $0) }
    }
    
    enum CodingKeys: String, CodingKey {
        case headline
        case lineCount
        case link
        
        static func lineKeys(lineCount: Int) -> [CodingKeys] {
            return (1...lineCount).compactMap { CodingKeys(stringValue: "p\($0)") }
        }
    }
    
    /// Convenience initializer for test data
    init(headline: String, link: String, lines: [String]) {
        id = UUID()
        self.headline = headline
        self.link = link
        self.lines = lines
    }
}
