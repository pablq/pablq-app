//
//  Game.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Game: Identifiable {
    let id = UUID()
    let isFavorite: Bool
    let headline: String
    let description: String
    let url: URL?
}
