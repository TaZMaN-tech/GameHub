//
//  SearchAssembly.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import UIKit

final class SearchAssembly: SearchAssemblyProtocol {
    
    private let deps: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.deps = dependencies
    }
    
    func build(coordinator: SearchNavigation) -> UIViewController {
        let viewController = SearchViewController()
        let interactor = SearchInteractor(gameService: deps.gameService)
        let router = SearchRouter(navigation: coordinator)
        
        let presenter = SearchPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        
        viewController.output = presenter
        interactor.output = presenter
        
        return viewController
    }
}
