//
//  ApplicationCoordinator.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 16.11.2025.
//

import UIKit

protocol ApplicationCoordinating: AnyObject {
    func start()
}

final class ApplicationCoordinator: ApplicationCoordinating {

    private let window: UIWindow

    private let tabBarController = UITabBarController()

    private let homeNavController = UINavigationController()
    private let favoritesNavController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {

        let homeVC = HomeAssembly().build(coordinator: self)
        homeNavController.viewControllers = [homeVC]
        homeNavController.tabBarItem = UITabBarItem(
            title: "GameHub",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let favoritesVC = FavoritesAssembly().build(coordinator: self)
        favoritesNavController.viewControllers = [favoritesVC]
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )


        tabBarController.viewControllers = [homeNavController, favoritesNavController]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

extension ApplicationCoordinator: HomeNavigation {
    func openGameDetails(for game: Game) {
        let vc = GameDetailsAssembly().build(game: game, coordinator: self)
        homeNavController.pushViewController(vc, animated: true)
    }
}

extension ApplicationCoordinator: GameDetailsNavigation {
    func closeDetails() {
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.popViewController(animated: true)
        }
    }
}

extension ApplicationCoordinator: FavoritesNavigation {
    func openGameDetails(fromFavorites game: Game) {
        let vc = GameDetailsAssembly().build(game: game, coordinator: self)
        favoritesNavController.pushViewController(vc, animated: true)
    }
}
