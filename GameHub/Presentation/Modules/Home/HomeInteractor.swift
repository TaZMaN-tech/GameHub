//
//  HomeInteractor.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

final class HomeInteractor:  HomeInteractorInput {
    
    weak var output: HomeInteractorOutput?
    
    private let gameService: GameServicing
    
    init(gameService: GameServicing) {
        self.gameService = gameService
    }
    
    func loadInitialData() {
        Task {
            do {
                let sections = try await self.gameService.fetchHomeSections()
                await MainActor.run {
                    self.output?.didLoad(sections: sections)
                }
            } catch {
                await MainActor.run {
                    self.output?.didFailLoading(error)
                }
            }
        }
    }
}
