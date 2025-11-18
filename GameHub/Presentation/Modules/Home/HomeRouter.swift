//
//  HomeRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeRouter: HomeRouterInput {
    
    weak var viewController: UIViewController?
    
    func openDetails(for game: Game) {
        let detailsViewController = GameDetailsModuleBuilder.build(with: game)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
