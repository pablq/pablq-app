//
//  TestData.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

enum TestData {
    static let testSport = Sport(league: "mlb",
                                 imageAssetName: "baseball",
                                 activeImageAssetName: "baseball_active")
    static let testGame = Game(isFavorite: true,
                               headline: "Headline",
                               description: "A\nMultiline\nDescription",
                               url: URL(string: "https://github.com/pablq/pablq-website")!)
}


