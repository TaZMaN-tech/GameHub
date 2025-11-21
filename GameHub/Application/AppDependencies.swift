//
//  AppDependencies.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 21.11.2025.
//

import Foundation

struct AppDependencies {
    let netWorkService: NetworkServicing
    let gameService: GameServicing
    let favoritesStorage: FavoriteGameStoring
}

extension AppDependencies {
    static func makeDefault() -> AppDependencies {
        let network = NetworkService()
        let gameService = GameService(networkService: network)
        let favorites = FavoriteGameStorage()
        
        return AppDependencies(
            netWorkService: network,
            gameService: gameService,
            favoritesStorage: favorites
        )
    }
}
