//
//  GameDetailsModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class GameDetailsAssembly: GameDetailsAssemblyProtocol {
    
    private let deps: AppDependencies
    
    init(deps: AppDependencies) {
        self.deps = deps
    }
    
    func build(game: Game, coordinator: GameDetailsNavigation) -> UIViewController {
        let view = GameDetailsViewController()
        let interactor = GameDetailsInteractor(game: game,
                                               favorites: deps.favoritesStorage)
        
        let router = GameDetailsRouter(navigation: coordinator)
        
        let presenter = GameDetailsPresenter(interactor: interactor,
                                             router: router,
                                             game: game)
        
        view.output = presenter
        presenter.view = view
        interactor.output = presenter
        
        return view
    }
}
