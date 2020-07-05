//
//  Link.swift
//  pablq-app
//
//  Created by Pablo Philipps on 7/4/20.
//

import Foundation

struct Link: Identifiable {
    let id = UUID()
    let userFacingString: String
    let url: URL?
}
