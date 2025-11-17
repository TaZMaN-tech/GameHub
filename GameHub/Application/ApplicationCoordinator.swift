//
//  ApplicationCoordinator.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 16.11.2025.
//

import UIKit

final class ApplicationCoordinator {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeVC = HomeModuleBuilder.build()
        navigationController.viewControllers = [homeVC]
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
