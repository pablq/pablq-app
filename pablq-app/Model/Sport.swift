//
//  Sport.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Sport: Identifiable, Equatable {
    var id = UUID()
    let league: String
    let imageName: String
    let activeImageName: String
}
