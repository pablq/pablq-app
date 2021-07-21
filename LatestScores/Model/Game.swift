//
//  Game.swift
//  LatestScores
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Game: Identifiable, Decodable {
    let id = UUID() // swiftlint:disable:this identifier_name
    let headline: String
    private let link: String
    private let lines: [String]

    var isLive: Bool {
        !isUpcoming && !isOver
    }

    var isUpcoming: Bool {
        headline.lowercased().contains("et)") || headline.lowercased().contains("(delayed")
    }

    var isOver: Bool {
        headline.lowercased().contains("(final") || headline.lowercased().contains("(postponed")
    }

    var description: String {
        lines.joined(separator: "\n")
    }

    var url: URL? {
        URL(string: link)
    }

    struct CodingKeys: CodingKey {
        static let headline = Self.init(stringValue: "headline")!
        static let lineCount = Self.init(stringValue: "lineCount")!
        static let link = Self.init(stringValue: "link")!
        static func lines(lineCount: Int) -> [CodingKeys] {
            return lineCount < 1 ? [] : (1...lineCount).compactMap { Self.init(stringValue: "p\($0)") }
        }

        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?

        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headline = try values.decode(String.self, forKey: .headline)
        link = try values.decode(String.self, forKey: .link)
        let lineCount = try values.decode(Int.self, forKey: .lineCount)
        lines = try CodingKeys.lines(lineCount: lineCount).map { try values.decode(String.self, forKey: $0)}
    }

    /// Convenience initializer for test data
    init(headline: String, link: String, lines: [String]) {
        self.headline = headline
        self.link = link
        self.lines = lines
    }
}
