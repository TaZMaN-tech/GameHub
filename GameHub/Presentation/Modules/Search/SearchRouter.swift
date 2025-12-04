//
//  SearchRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import UIKit

final class SearchRouter: SearchRouterInput {
    
    private weak var navigation: SearchNavigation?
    
    init(navigation: SearchNavigation) {
        self.navigation = navigation
    }
    
    func routeToGameDetails(_ game: Game) {
        navigation?.openGameDetails(fromSearch: game)
    }
}
