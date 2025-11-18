//
//  FavoriteGameStorage.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import Foundation
import CoreData

protocol FavoriteGameStoring {
    func isFavorite(gameID: Int) -> Bool
    func toggleFavorite(_ game: Game) throws
    func allFavorites() -> [Game]
}

final class FavoriteGameStorage: FavoriteGameStoring {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.viewContext) {
        self.context = context
    }
    
    func isFavorite(gameID: Int) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
        request.predicate = NSPredicate(format: "id == %d", gameID)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("isFavorite error:", error)
            return false
        }
    }
    
    func toggleFavorite(_ game: Game) throws {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FavoriteGame")
        request.predicate = NSPredicate(format: "id == %d", game.id)
        request.fetchLimit = 1
        
        let results = try context.fetch(request)
        
        if let existing = results.first {
            context.delete(existing)
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteGame", in: context) else {
                return
            }
            let favorite = NSManagedObject(entity: entity, insertInto: context)
            favorite.setValue(Int64(game.id), forKey: "id")
            favorite.setValue(game.name, forKey: "name")
            favorite.setValue(game.genre, forKey: "genre")
            favorite.setValue(game.rating, forKey: "rating")
            favorite.setValue(game.backgroundImageURL?.absoluteString, forKey: "imageURL")
            favorite.setValue(Date(), forKey: "createdAt")
        }
        try context.save()
    }
    
    func allFavorites() -> [Game] {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "FavoriteGame")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            let objects = try context.fetch(request)
            return objects.compactMap { object in
                guard
                    let name = object.value(forKey: "name") as? String,
                    let genre = object.value(forKey: "genre") as? String,
                    let imageURLString = object.value(forKey: "imageURL") as? String?
                else { return nil }
                
                let id = (object.value(forKey: "id") as? Int64).map(Int.init) ?? 0
                let rating = object.value(forKey: "rating") as? Double ?? 0
                let url = imageURLString.flatMap {
                    URL(string: $0)
                }
                
                return Game(id: id,
                            name: name,
                            genre: genre,
                            rating: rating,
                            backgroundImageURL: url)
            }
        } catch {
            print("allFavorites error:", error)
            return []
        }
    }
    
     
    
}
