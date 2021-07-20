//
//  AppAppearance.swift
//  LatestScores
//
//  Created by Pablo Philipps on 1/23/21.
//

import UIKit

class AppAppearance {
    init() {
        #if os(iOS)
        UITableView.appearance().backgroundColor = UIColor.clear
        #endif
    }
}
