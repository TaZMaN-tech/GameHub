//
//  HomeRouter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeRouter: HomeRouterInput {
    
    weak var viewController: UIViewController?
    
    func openDetails(for id: Int) {
        print("Открываем детали игры id:", id)
    }
}
