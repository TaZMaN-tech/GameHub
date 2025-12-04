//
//  GameService.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation


protocol GameServicing {
    func fetchHomeSections() async throws -> [HomeSection]
    func searchGames(query: String, page: Int) async throws -> [Game]
}

final class GameService: GameServicing {
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
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
        
        var sections: [HomeSection] = []
        
        if let bannerGame = trending.first ?? popular.first ?? topRated.first {
            sections.append(HomeSection(type: .banner, title: nil, games: [bannerGame]))
        }
        
        if !popular.isEmpty {
            sections.append(HomeSection(type: .horizontal, title: Strings.Sections.popular, games: popular))
        }
        if !topRated.isEmpty {
            sections.append(HomeSection(type: .horizontal, title: Strings.Sections.topRated, games: topRated))
        }
        if !upcoming.isEmpty {
            sections.append(HomeSection(type: .horizontal, title: Strings.Sections.upcoming, games: upcoming))
        }
        
        return sections
    }
    
    func searchGames(query: String, page: Int) async throws -> [Game] {
        let response: RAWGGameResponseDTO = try await networkService.request(
            RAWGEndpoint.search(query: query, page: page)
        )
        return response.results.map { $0.toDomain() }
    }
}
