//
//  SwiftUI+LatestScores.swift
//  LatestScores
//
//  Created by Pablo Philipps on 4/7/21.
//

import SwiftUI

extension Image {
    init(_ asset: ImageAsset) {
        if asset.isSystemImage {
            self.init(systemName: asset.rawValue)
        } else {
            self.init(asset.rawValue)
        }
    }
}

extension Color {
    init(_ asset: ColorAsset) {
        self.init(asset.rawValue)
    }
}
