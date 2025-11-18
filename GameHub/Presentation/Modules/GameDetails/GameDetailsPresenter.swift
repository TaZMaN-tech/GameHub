//
//  GameDetailsPresenter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation

final class GameDetailsPresenter {
     
    weak var view: GameDetailsViewInput?
    
    private let interactor: GameDetailsInteractorInput
    private let router: GameDetailsRouterInput
    private let game: Game
    private let favorites: FavoriteGameStoring
    
    private var isFavorite: Bool = false
    
    init(interactor: GameDetailsInteractorInput, router: GameDetailsRouterInput, game: Game, favorites: FavoriteGameStoring) {
        self.interactor = interactor
        self.router = router
        self.game = game
        self.favorites = favorites
    }
    
    private func makeViewModel() -> GameDetailsViewModel {
        GameDetailsViewModel(
            title: game.name,
            genre: game.genre,
            ratingText: game.rating > 0 ? "⭐️ \(String(format: "%.1f", game.rating))" : "Нет рейтинга",
            imageURL: game.backgroundImageURL,
            isFavorite: isFavorite
        )
    }
}

extension GameDetailsPresenter: GameDetailsViewOutput {
    func viewDidLoad() {
        let viewModel = makeViewModel()
        view?.display(viewModel: viewModel)
    }
    
    func didTapFavorite() {
        do {
            try favorites.toggleFavorite(game)
            isFavorite.toggle()
            view?.updateFavorite(isFavorite: isFavorite)
        } catch {
            print("toggleFavorite error:", error)
        }
    }
}

extension GameDetailsPresenter: GameDetailsInteractorOutput {
    
}
