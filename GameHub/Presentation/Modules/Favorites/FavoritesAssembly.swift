//
//  FavoritesModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class FavoritesAssembly: FavoritesAssemblyProtocol {

    func build(coordinator: FavoritesNavigation) -> UIViewController {

        let interactor = FavoritesInteractor()
        let router = FavoritesRouter(navigation: coordinator)
        let presenter = FavoritesPresenter(interactor: interactor, router: router)
        let view = FavoritesViewController()

        view.output = presenter
        presenter.view = view
        interactor.output = presenter

        return view
    }
}
