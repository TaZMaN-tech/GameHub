//
//  HomeInteractor.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

final class HomeInteractor:  HomeInteractorInput {
    
    weak var output: HomeInteractorOutput?
    
    func loadInitialData() {
        output?.didLoadData()
    }
    
    
}
