//
//  Game.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 02/10/22.
//

import Foundation

struct GameList: Codable {
    let next: String?
    let previous: String?
    let count: Int?
    let results: [Game]?
}

struct Game: Identifiable, Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let description: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let website: String?
    let rating: Double?
}

