//
//  HomeModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeAssembly: HomeAssemblyProtocol {
    func build(coordinator: HomeNavigation) -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter(navigation: coordinator)

        let presenter = HomePresenter(
            interactor: interactor,
            router: router
        )

        presenter.view = view
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
