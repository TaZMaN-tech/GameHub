//
//  ApplicationCoordinator.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 16.11.2025.
//

import UIKit

final class ApplicationCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeModuleBuilder.build()
        let favoritesVC = FavoritesModuleBuilder.build()
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites",
                                               image: UIImage(systemName: "star"),
                                               selectedImage: UIImage(systemName: "star.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, favoritesNav]
        
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
}
