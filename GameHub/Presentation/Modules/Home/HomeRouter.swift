//
//  HomeRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeRouter: HomeRouterInput {
    
    weak var navigation: HomeNavigation?
    
    init(navigation: HomeNavigation) {
        self.navigation = navigation
    }
    
    func routeToGameDetails(_ game: Game) {
        navigation?.openGameDetails(for: game)
    }
}
