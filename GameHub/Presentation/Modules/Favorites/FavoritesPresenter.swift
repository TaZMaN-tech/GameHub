//
//  FavoritesPresenter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation

final class FavoritesPresenter {
    
    weak var view: FavoritesViewInput?
    
    private let interactor: FavoritesInteractorInput
    private let router: FavoritesRouterInput
    
    private var games: [Game] = []
    
    init(interactor: FavoritesInteractorInput, router: FavoritesRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func makeViewModels(from games: [Game]) -> [FavoriteGameViewModel] {
        games.map {
            FavoriteGameViewModel(
                title: $0.name,
                subtitle: "\($0.genre)  •  ⭐️ \(String(format: "%.1f", $0.rating))",
                imageURL: $0.backgroundImageURL
            )
        }
    }
}

extension FavoritesPresenter: FavoritesViewOutput {
    
    func viewDidLoad() {
        interactor.fetchFavorites()
    }
    
    func viewWillAppear() {
        interactor.fetchFavorites()
    }
    
    func didSelectRow(at index: Int) {
        guard index < games.count else { return }
        router.openDetails(games[index])
    }
    
    func didDeleteRow(at index: Int) {
        guard index < games.count else { return }
        interactor.removeFavorite(game: games[index])
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    
    func didLoadFavorites(_ games: [Game]) {
        self.games = games
        
        let viewModels = makeViewModels(from: games)
        view?.display(games: viewModels)
        view?.showEmptyState(games.isEmpty)
    }
}
