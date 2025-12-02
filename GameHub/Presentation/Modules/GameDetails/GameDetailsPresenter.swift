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
    
    
    
    init(
        view: GameDetailsViewInput,
        interactor: GameDetailsInteractorInput,
        router: GameDetailsRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func makeViewModel(from game: Game, isFavorite: Bool) -> GameDetailsViewModel {
        return GameDetailsViewModel(
            title: game.name,
            genre: game.genre,
            ratingText: game.formattedRating,
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
        let viewModel = makeViewModel(from: game, isFavorite: isFavorite)
        view?.display(viewModel: viewModel)
    }
    
    func didUpdateFavorite(isFavorite: Bool) {
        view?.updateFavorite(isFavorite: isFavorite)
    }
    
    func didFailWithError(_ error: Error) {
        // В будущем можно показать alert пользователю
        print("GameDetails error: \(error.localizedDescription)")
    }
}
