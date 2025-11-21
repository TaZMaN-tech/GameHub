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
        let games = storage.allFavorites()
        output?.didLoadFavorites(games)
    }
    
    func removeFavorite(game: Game) {
        do {
            try storage.toggleFavorite(game)
            let games = storage.allFavorites()
            output?.didLoadFavorites(games)
        } catch {
            print("removeFavorite error:", error)
        }
    }
}
