//
//  GameDetailsInteractor.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation

final class GameDetailsInteractor: GameDetailsInteractorInput {
    
    weak var output: GameDetailsInteractorOutput?
    
    private let game: Game
    private let favorites: FavoriteGameStoring
    
    init(game: Game, favorites: FavoriteGameStoring) {
        self.game = game
        self.favorites = favorites
    }
    
    func load() {
        do {
            let isFavorite = try favorites.isFavorite(gameID: game.id)
            output?.didLoad(game: game, isFavorite: isFavorite)
        } catch {
            output?.didFailWithError(error)
            output?.didLoad(game: game, isFavorite: false)
        }
    }
    
    func refreshFavoriteState() {
        do {
            let isFavorite = try favorites.isFavorite(gameID: game.id)
            output?.didUpdateFavorite(isFavorite: isFavorite)
        } catch {
            output?.didFailWithError(error)
            output?.didUpdateFavorite(isFavorite: false)
        }
    }
    
    func toggleFavorite() {
        do {
            try favorites.toggleFavorite(game)
            refreshFavoriteState()
        } catch {
            output?.didFailWithError(error)
        }
    }
    
}
