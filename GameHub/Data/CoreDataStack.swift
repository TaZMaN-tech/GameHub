//
//  CoreDataStack.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import CoreData

protocol CoreDataStackProviding {
    var viewContext: NSManagedObjectContext { get }
    func saveContext()
}

final class CoreDataStack: CoreDataStackProviding {
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(modelName: String = "GameHub") {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { description, error in
            if let error {
                print("⚠️ CoreData persistent store error: \(error)")
                print("⚠️ Falling back to in-memory store")
            }
            
            let inMemoryDescription = NSPersistentStoreDescription()
            inMemoryDescription.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [inMemoryDescription]
            
            container.loadPersistentStores { _, fallbackError in
                if let fallbackError {
                    print("⚠️ Fallback in-memory store error: \(fallbackError)")
                }
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
