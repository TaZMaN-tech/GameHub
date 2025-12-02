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
    func viewWillAppear()
    func didTapFavorite()
}

// MARK: - Interactor

protocol GameDetailsInteractorInput: AnyObject {
    func load()
    func refreshFavoriteState()
    func toggleFavorite()
}

protocol GameDetailsInteractorOutput: AnyObject {
    func didLoad(game: Game, isFavorite: Bool)
    func didUpdateFavorite(isFavorite: Bool)
    func didFailWithError(_ error: Error)
}

// MARK: - Router

protocol GameDetailsRouterInput: AnyObject {
    func close()
}

// MARK: - Navigation

protocol GameDetailsNavigation: AnyObject {
    func closeDetails()
}

// MARK: - Assembly

protocol GameDetailsAssemblyProtocol {
    func build(game: Game, coordinator: GameDetailsNavigation) -> UIViewController
}
