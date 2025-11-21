//
//  FavoriteGame+CoreDataProperties.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 21.11.2025.
//
//

public import Foundation
public import CoreData


public typealias FavoriteGameCoreDataPropertiesSet = NSSet

extension FavoriteGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGame> {
        return NSFetchRequest<FavoriteGame>(entityName: "FavoriteGame")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var genre: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double

}

extension FavoriteGame : Identifiable {

}
