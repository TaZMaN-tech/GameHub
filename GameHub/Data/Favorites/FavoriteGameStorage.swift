//
//  FavoriteGameStorage.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation
import CoreData

protocol FavoriteGameStoring {
    func isFavorite(gameID: Int) throws -> Bool
    func toggleFavorite(_ game: Game) throws
    func allFavorites() throws -> [Game]
}

final class FavoriteGameStorage: FavoriteGameStoring {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func isFavorite(gameID: Int) throws -> Bool {
        let request = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", gameID)
        request.fetchLimit = 1
        
        let count = try context.count(for: request)
        return count > 0
    }
    
    func toggleFavorite(_ game: Game) throws {
        let request = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", game.id)
        request.fetchLimit = 1
        
        let results = try context.fetch(request)
        
        if let existing = results.first {
            context.delete(existing)
        } else {
            let favorite = FavoriteGame(context: context)
            favorite.id = Int64(game.id)
            favorite.name = game.name
            favorite.genre = game.genre
            favorite.rating = game.rating
            favorite.imageURL = game.backgroundImageURL?.absoluteString
            favorite.createdAt = Date()
        }
        try context.save()
    }
    
    func allFavorites() throws -> [Game] {
        let request = FavoriteGame.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteGame.createdAt), ascending: false)]
        
        let objects = try context.fetch(request)
        return objects.map { favorite in
            let url = favorite.imageURL.flatMap { URL(string: $0) }
            
            return Game(
                id: Int(favorite.id),
                name: favorite.name ?? "Unknown",
                genre: favorite.genre ?? "Unknown",
                rating: favorite.rating,
                backgroundImageURL: url
            )
        }
    }
}
