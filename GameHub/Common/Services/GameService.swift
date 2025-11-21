//
//  GameService.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation


protocol GameServicing {
    func fetchHomeSections() async throws -> [HomeSection]
}

final class GameService: GameServicing {
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchHomeSections() async throws -> [HomeSection] {
        
        async let trendingResponse: RAWGGameResponseDTO = networkService.request(
            RAWGEndpoint.trending(page: 1)
        )
        async let popularResponse: RAWGGameResponseDTO = networkService.request(
            RAWGEndpoint.popular(page: 1)
        )
        async let topRatedResponse: RAWGGameResponseDTO = networkService.request(
            RAWGEndpoint.topRated(page: 1)
        )
        async let upcomingResponse: RAWGGameResponseDTO = networkService.request(
            RAWGEndpoint.upcoming(page: 1)
        )
        
        let trending = try await trendingResponse.results.map { $0.toDomain() }
        let popular = try await popularResponse.results.map { $0.toDomain() }
        let topRated = try await topRatedResponse.results.map { $0.toDomain() }
        let upcoming = try await upcomingResponse.results.map { $0.toDomain() }
        
        let bannerGame = trending.first ?? popular.first ?? topRated.first ?? upcoming.first ?? Game(id: 0, name: "Unknown", genre: "Unknown", rating: 0, backgroundImageURL: nil)
        
        return [
            HomeSection(type: .banner, title: nil, games: [bannerGame]),
            HomeSection(type: .horizontal, title: "Популярное", games: popular),
            HomeSection(type: .horizontal, title: "Топ по рейтингу", games: topRated),
            HomeSection(type: .horizontal, title: "Скоро выйдет", games: upcoming)
    ]
    }
}
