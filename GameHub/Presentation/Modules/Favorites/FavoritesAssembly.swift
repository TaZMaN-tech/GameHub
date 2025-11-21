//
//  FavoritesModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class FavoritesAssembly: FavoritesAssemblyProtocol {
    
    private let deps: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.deps = dependencies
    }
    
    func build(coordinator: FavoritesNavigation) -> UIViewController {
        let viewController = FavoritesViewController()
        let interactor = FavoritesInteractor(storage: deps.favoritesStorage)
        let router = FavoritesRouter(navigation: coordinator)
        
        let presenter = FavoritesPresenter(view: viewController,
                                           interactor: interactor,
                                           router: router)
        
        viewController.output = presenter
        interactor.output = presenter
        
        return viewController
    }
}
