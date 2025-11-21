//
//  HomeModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeAssembly: HomeAssemblyProtocol {
    private let deps: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.deps = dependencies
    }
    
    func build(coordinator: HomeNavigation) -> UIViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor(gameService: deps.gameService)
        let router = HomeRouter(navigation: coordinator)
        let presenter = HomePresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        
        viewController.output = presenter
        interactor.output = presenter
        
        return viewController
    }
}
