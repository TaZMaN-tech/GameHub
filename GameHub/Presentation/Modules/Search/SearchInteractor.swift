//
//  SearchInteractor.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import Foundation

final class SearchInteractor: SearchInteractorInput {
    
    weak var output: SearchInteractorOutput?
    
    private let gameService: GameServicing
    private var searchTask: Task<Void, Never>?
    
    init(gameService: GameServicing) {
        self.gameService = gameService
    }
    
    func searchGames(query: String) {
        // Отменяем предыдущий запрос
        searchTask?.cancel()
        
        // Не ищем пустую строку
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            output?.didFind(games: [])
            return
        }
        
        searchTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                let games = try await self.gameService.searchGames(query: query, page: 1)
                
                // Проверяем, что задача не была отменена
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    self.output?.didFind(games: games)
                }
            } catch {
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    self.output?.didFailWithError(error)
                }
            }
        }
    }
    
    func cancelSearch() {
        searchTask?.cancel()
    }
    
}
