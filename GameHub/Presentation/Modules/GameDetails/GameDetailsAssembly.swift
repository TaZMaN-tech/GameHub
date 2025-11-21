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
        let viewController = GameDetailsViewController()
        let interactor = GameDetailsInteractor(game: game,
                                               favorites: deps.favoritesStorage)
        
        let router = GameDetailsRouter(navigation: coordinator)
        
        let presenter = GameDetailsPresenter(view: viewController,
                                             interactor: interactor,
                                             router: router)
        
        viewController.output = presenter
        interactor.output = presenter
        
        return viewController
    }
}
