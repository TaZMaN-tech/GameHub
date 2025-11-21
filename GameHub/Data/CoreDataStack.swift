//
//  CoreDataStack.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        let container = NSPersistentContainer(name: "GameHub")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unresolved CoreData error: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        self.persistentContainer = container
    }
    
    func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreData save error:", error)
        }
    }
}
