//
//  FavoritesModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

enum FavoritesModuleBuilder {
    
    static func build() -> UIViewController {
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(interactor: interactor, router: router)
        let viewController = FavoritesViewController()
        
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        router.viewController = viewController
        
        return viewController
    }
}
