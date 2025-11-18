//
//  RAWGGameDTO.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

struct RAWGGameResponseDTO: Decodable {
    let results: [RAWGGameDTO]
}

struct RAWGGameDTO: Decodable {
    let id: Int
    let name: String
    let rating: Double?
    let genres: [RAWGGenreDTO]?
    let backgroundImage: String?
}

struct RAWGGenreDTO: Decodable {
    let name: String
}

extension RAWGGameDTO {
    func toDomain() -> Game {
        let genreName = self.genres?.first?.name ?? "Unknown"
        let url: URL?
        if let backgroundImage, let imageURL = URL(string: backgroundImage) {
            url = imageURL
        } else {
            url = nil
        }
        
        return Game(
            id: self.id,
            name: self.name,
            genre: genreName,
            rating: self.rating ?? 0,
            backgroundImageURL: url
        )
    }
}
