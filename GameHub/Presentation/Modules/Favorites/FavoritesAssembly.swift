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
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor(storage: deps.favoritesStorage)
        let router = FavoritesRouter(navigation: coordinator)
        
        let presenter = FavoritesPresenter(interactor: interactor,
                                           router: router)
        
        view.output = presenter
        presenter.view = view
        interactor.output = presenter
        
        return view
    }
}
