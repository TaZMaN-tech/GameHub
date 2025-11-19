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
        let isFavorite = favorites.isFavorite(gameID: game.id)
        output?.didLoad(game: game, isFavorite: isFavorite)
    }
    
    func refreshFavoriteState() {
        let isFavorite = favorites.isFavorite(gameID: game.id)
        output?.didUpdateFavorite(isFavorite: isFavorite)
    }
    
    func toggleFavorite() {
        do {
            try favorites.toggleFavorite(game)
            refreshFavoriteState()
        } catch {
            print("toggleFavorite error:", error)
        }
    }
    
}
