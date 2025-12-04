//
//  SearchProtocols.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import UIKit

// MARK: - View

protocol SearchViewInput: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func display(games: [SearchGameViewModel])
    func showEmptyState(_ isEmpty: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidLoad()
    func didChangeSearchText(_ text: String)
    func didSelectGame(at index: Int)
}

// MARK: - Interactor

protocol SearchInteractorInput: AnyObject {
    func searchGames(query: String)
    func cancelSearch()
}

protocol SearchInteractorOutput: AnyObject {
    func didFind(games: [Game])
    func didFailWithError(_ error: Error)
}

// MARK: - Router

protocol SearchRouterInput: AnyObject {
    func routeToGameDetails(_ game: Game)
}

// MARK: - Navigation

protocol SearchNavigation: AnyObject {
    func openGameDetails(fromSearch game: Game)
}

// MARK: - Assembly

protocol SearchAssemblyProtocol {
    func build(coordinator: SearchNavigation) -> UIViewController
}
