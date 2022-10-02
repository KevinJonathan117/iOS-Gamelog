//
//  GameDetail.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 02/10/22.
//

import Foundation

struct GameDetail: Codable {
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
