//
//  FavoritesInteractor.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation

final class FavoritesInteractor: FavoritesInteractorInput {
    
    weak var output: FavoritesInteractorOutput?
    
    private let storage: FavoriteGameStoring
    
    init(storage: FavoriteGameStoring) {
        self.storage = storage
    }
    
    func fetchFavorites() {
        do {
            let games = try storage.allFavorites()
            output?.didLoadFavorites(games)
        } catch {
            output?.didFailWithError(error)
        }
    }
    
    func removeFavorite(game: Game) {
        do {
            try storage.toggleFavorite(game)
            let games = try storage.allFavorites()
            output?.didLoadFavorites(games)
        } catch {
            output?.didFailWithError(error)
        }
    }
}
