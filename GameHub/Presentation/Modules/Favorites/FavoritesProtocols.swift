//
//  FavoritesProtocols.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

// MARK: - View

protocol FavoritesViewInput: AnyObject {
    func display(games: [FavoriteGameViewModel])
    func showEmptyState(_ isEmpty: Bool)
}

protocol FavoritesViewOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectRow(at index: Int)
    func didDeleteRow(at index: Int)
}

// MARK: - Interactor

protocol FavoritesInteractorInput: AnyObject {
    func fetchFavorites()
    func removeFavorite(game: Game)
}

protocol FavoritesInteractorOutput: AnyObject {
    func didLoadFavorites(_ games: [Game])
    func didFailWithError(_ error: Error)
}

// MARK: - Router

protocol FavoritesRouterInput: AnyObject {
    func routeToGameDetails(_ game: Game)
}

// MARK: - Navigation

protocol FavoritesNavigation: AnyObject {
    func openGameDetails(fromFavorites game: Game)
}

// MARK: - Assembly

protocol FavoritesAssemblyProtocol {
    func build(coordinator: FavoritesNavigation) -> UIViewController
}
