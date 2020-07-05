//
//  Sport.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Sport: Identifiable {
    var id = UUID()
    let name: String
    let imageAssetName: String
    let activeImageAssetName: String
}
