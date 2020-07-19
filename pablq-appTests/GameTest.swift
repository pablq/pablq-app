//
//  GameTest.swift
//  pablq-appTests
//
//  Created by Pablo Philipps on 7/6/20.
//

import XCTest

@testable import pablq_app

class GameTest: XCTestCase {
    func testInit_setsUniqueId() {
        let game0 = Game(headline: "", link: "", lines: [])
        let game1 = Game(headline: "", link: "", lines: [])
        
        XCTAssertNotEqual(game0.id, game1.id)
    }
    
    func testInitWithDecoder_setsUniqueId() {
        let json = """
        {
            "headline": "The Second Game Headline",
            "lineCount": 2,
            "link": "http://www.pablq.website/",
            "p1": "This is the first line",
            "p2": "This is the second line"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        guard let game0 = try? decoder.decode(Game.self, from: json),
              let game1 = try? decoder.decode(Game.self, from: json) else {
            XCTFail("Unable to instantiate game models")
            return
        }
        XCTAssertNotEqual(game0.id, game1.id)
    }
    
    func testInitWithDecoder_decodesDynamicJson() {
        let json = """
        [
            {
                "headline": "The First Game Headline",
                "lineCount": 4,
                "link": "http://www.pablq.website/",
                "p1": "This is the first line",
                "p2": "This is the second line",
                "p3": "This is the third line",
                "p4": "This is the fourth line"
            },
            {
                "headline": "The Second Game Headline",
                "lineCount": 2,
                "link": "http://www.pablq.website/",
                "p1": "This is the first line",
                "p2": "This is the second line"
            },
            {
                "headline": "The Third Game Headline",
                "lineCount": 0,
                "link": "http://www.pablq.website/",
            }
        ]
        """.data(using: .utf8)!
        
        let games = try? JSONDecoder().decode([Game].self, from: json)
        XCTAssertEqual(games?.count, 3)
    }
    
    func testIsFavorite_whenHeadlineIncludesChicago_returnsTrue() {
        let game = Game(headline: "Chicago Bears", link: "", lines: [])
        XCTAssertTrue(game.isFavorite)
    }
    
    func testIsFavorite_whenHeadlineDoesNotIncludeChicago_returnsFalse() {
        let game = Game(headline: "Detroit Lions", link: "", lines: [])
        XCTAssertFalse(game.isFavorite)
    }
    
    func testDescription_isComposedOfLines() {
        let lines = ["The first line.", "The second line", "The third line"]
        let game = Game(headline: "", link: "", lines: lines)
        for line in lines {
            XCTAssertTrue(game.description.contains(line))
        }
    }
    
    func testUrl_isBuiltFromLink() {
        let link = "http://www.pablq.website/"
        let game = Game(headline: "", link: link, lines: [])
        
        XCTAssertEqual(game.url?.absoluteString, link)
    }
}
