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
    
    init(interactor: GameDetailsInteractorInput, router: GameDetailsRouterInput, game: Game) {
        self.interactor = interactor
        self.router = router
        self.game = game
    }
    
    private func makeViewModel() -> GameDetailsViewModel {
        GameDetailsViewModel(
            title: game.name,
            genre: game.genre,
            ratingText: game.rating > 0 ? "⭐️ \(String(format: "%.1f", game.rating))" : "Нет рейтинга"
        )
    }
}

extension GameDetailsPresenter: GameDetailsViewOutput {
    func viewDidLoad() {
        let viewModel = makeViewModel()
        view?.display(viewModel: viewModel)
    }
}

extension GameDetailsPresenter: GameDetailsInteractorOutput {
    
}
