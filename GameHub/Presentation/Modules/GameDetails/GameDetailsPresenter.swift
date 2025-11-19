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
    
    private var game: Game
    private var isFavorite: Bool = false
    
    init(interactor: GameDetailsInteractorInput, router: GameDetailsRouterInput, game: Game) {
        self.interactor = interactor
        self.router = router
        self.game = game
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
        interactor.load()
    }
    
    func viewWillAppear() {
        interactor.refreshFavoriteState()
    }
    
    func didTapFavorite() {
        interactor.toggleFavorite()
    }
}

extension GameDetailsPresenter: GameDetailsInteractorOutput {
    
    func didLoad(game: Game, isFavorite: Bool) {
        self.game = game
        self.isFavorite = isFavorite
        let viewModel = makeViewModel()
        view?.updateFavorite(isFavorite: isFavorite)
        view?.display(viewModel: viewModel)
    }
    
    func didUpdateFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
        view?.updateFavorite(isFavorite: isFavorite)
    }
    
    
}
