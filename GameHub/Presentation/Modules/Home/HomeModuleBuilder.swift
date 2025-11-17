//
//  HomeModuleBuilder.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

enum HomeModuleBuilder {
    
    static func build() -> UIViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let view = HomeViewController()
        
        view.output = presenter
        presenter.view = view
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
