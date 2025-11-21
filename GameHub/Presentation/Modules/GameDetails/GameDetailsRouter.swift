//
//  GameDetailsRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class GameDetailsRouter: GameDetailsRouterInput {

    private weak var navigation: GameDetailsNavigation?

    init(navigation: GameDetailsNavigation) {
        self.navigation = navigation
    }

    func close() {
        navigation?.closeDetails()
    }
}
