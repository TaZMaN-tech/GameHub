//
//  GameDetailsProtocols.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

// MARK: - View

protocol GameDetailsViewInput: AnyObject {
    func display(viewModel: GameDetailsViewModel)
    func updateFavorite(isFavorite: Bool)
}

protocol GameDetailsViewOutput: AnyObject {
    func viewDidLoad()
    func didTapFavorite()
}

// MARK: - Interactor

protocol GameDetailsInteractorInput: AnyObject {
    
}

protocol GameDetailsInteractorOutput: AnyObject {
    
}

// MARK: - Router

protocol GameDetailsRouterInput: AnyObject {
    
}
