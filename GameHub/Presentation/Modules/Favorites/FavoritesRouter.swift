//
//  FavoritesRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class FavoritesRouter: FavoritesRouterInput {

    private weak var navigation: FavoritesNavigation?

    init(navigation: FavoritesNavigation) {
        self.navigation = navigation
    }

    func routeToGameDetails(_ game: Game) {
        navigation?.openGameDetails(fromFavorites: game)
    }
}
