//
//  AppDependencies.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 21.11.2025.
//

import Foundation

struct AppDependencies {
    let gameService: GameServicing
    let favoritesStorage: FavoriteGameStoring
}

extension AppDependencies {
    static func makeDefault() -> AppDependencies {
        AppDependencies(
            gameService: GameService(),
            favoritesStorage: FavoriteGameStorage()
        )
    }
}
