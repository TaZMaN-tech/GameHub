//
//  GameDetailsModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class GameDetailsAssembly: GameDetailsAssemblyProtocol {

    func build(game: Game, coordinator: GameDetailsNavigation) -> UIViewController {
        let favorites = FavoriteGameStorage()
        let interactor = GameDetailsInteractor(game: game, favorites: favorites)
        let router = GameDetailsRouter(navigation: coordinator)

        let presenter = GameDetailsPresenter(
            interactor: interactor,
            router: router,
            game: game
        )

        let view = GameDetailsViewController()

        presenter.view = view
        view.output = presenter
        interactor.output = presenter

        return view
    }
}
