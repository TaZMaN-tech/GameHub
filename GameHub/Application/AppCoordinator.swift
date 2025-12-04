//
//  ApplicationCoordinator.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 16.11.2025.
//

import UIKit

protocol AppCoordinating: AnyObject {
    func start()
    func saveData()
}

final class AppCoordinator: AppCoordinating {

    private let window: UIWindow
    private let deps: AppDependencies

    private let tabBarController = UITabBarController()
    private let homeNavController = UINavigationController()
    private let searchNavController = UINavigationController()
    private let favoritesNavController = UINavigationController()

    init(window: UIWindow, dependencies: AppDependencies = .makeDefault()) {
        self.window = window
        self.deps = dependencies
    }

    func start() {

        let homeVC = HomeAssembly(dependencies: deps).build(coordinator: self)
        homeNavController.viewControllers = [homeVC]
        homeNavController.tabBarItem = UITabBarItem(
            title: Strings.Home.title,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchVC = SearchAssembly(dependencies: deps).build(coordinator: self)
        searchNavController.viewControllers = [searchVC]
        searchNavController.tabBarItem = UITabBarItem(
            title: Strings.Search.title,
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass.circle")
        )

        let favoritesVC = FavoritesAssembly(dependencies: deps).build(coordinator: self)
        favoritesNavController.viewControllers = [favoritesVC]
        favoritesNavController.tabBarItem = UITabBarItem(
            title: Strings.Favorites.title,
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )


        tabBarController.viewControllers = [
            homeNavController,
            searchNavController,
            favoritesNavController
        ]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func saveData() {
        deps.coreDataStack.saveContext()
    }
}

extension AppCoordinator: HomeNavigation {
    func openGameDetails(for game: Game) {
        let vc = GameDetailsAssembly(deps: deps).build(game: game, coordinator: self)
        homeNavController.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: GameDetailsNavigation {
    func closeDetails() {
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.popViewController(animated: true)
        }
    }
}

extension AppCoordinator: FavoritesNavigation {
    func openGameDetails(fromFavorites game: Game) {
        let vc = GameDetailsAssembly(deps: deps).build(game: game, coordinator: self)
        favoritesNavController.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: SearchNavigation {
    func openGameDetails(fromSearch game: Game) {
        let vc = GameDetailsAssembly(deps: deps).build(game: game, coordinator: self)
        searchNavController.pushViewController(vc, animated: true)
    }
}
