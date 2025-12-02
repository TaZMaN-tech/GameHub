//
//  Game.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

struct Game {
    let id: Int
    let name: String
    let genre: String
    let rating: Double
    let backgroundImageURL: URL?
}

extension Game {
    var formattedRating: String {
        if rating > 0 {
            return "⭐️ \(String(format: "%.1f", rating))"
        } else {
            return "Нет рейтинга"
        }
    }
}
