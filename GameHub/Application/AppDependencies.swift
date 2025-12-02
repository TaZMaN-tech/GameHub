//
//  AppDependencies.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 21.11.2025.
//

import Foundation

struct AppDependencies {
    let networkService: NetworkServicing
    let gameService: GameServicing
    let favoritesStorage: FavoriteGameStoring
    let coreDataStack: CoreDataStackProviding
}

extension AppDependencies {
    static func makeDefault() -> AppDependencies {
        let coreDataStack = CoreDataStack()
        let network = NetworkService()
        let gameService = GameService(networkService: network)
        let favorites = FavoriteGameStorage(context: coreDataStack.viewContext)
        
        return AppDependencies(
            networkService: network,
            gameService: gameService,
            favoritesStorage: favorites,
            coreDataStack: coreDataStack
        )
    }
}
