//
//  GameDetailsModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

enum GameDetailsModuleBuilder {
    
    static func build(with game: Game) -> UIViewController {
        let interactor = GameDetailsInteractor()
        let router = GameDetailsRouter()
        let presenter = GameDetailsPresenter(interactor: interactor, router: router, game: game)
        let viewController = GameDetailsViewController()
        
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController
        
        return viewController
        
    }
}
