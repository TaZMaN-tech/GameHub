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
        let bannerGame = Game(
            id: 1,
            name: "Elden Ring",
            genre: "Action RPG",
            rating: 9.5,
            backgroundImageURL: nil
        )
        
        let popular = (2...8).map {
            Game(
                id: $0,
                name: "Популярная игра #\($0)",
                genre: "Adventure",
                rating: 8.5,
                backgroundImageURL: nil
            )
        }
        
        let topRated = (9...15).map {
            Game(
                id: $0,
                name: "Топовая игра #\($0)",
                genre: "RPG",
                rating: 9.2,
                backgroundImageURL: nil
            )
        }
        
        let upcoming = (16...22).map {
            Game(
                id: $0,
                name: "Скоро выйдет #\($0)",
                genre: "Indie",
                rating: 0,
                backgroundImageURL: nil
            )
        }
        
        let sections: [HomeSection] = [
            HomeSection(type: .banner, title: nil, games: [bannerGame]),
            HomeSection(type: .horizontal, title: "Популярное", games: popular),
            HomeSection(type: .horizontal, title: "Топ по рейтингу", games: topRated),
            HomeSection(type: .horizontal, title: "Скоро выйдет", games: upcoming)
        ]
        
        output?.didLoad(sections: sections)
    }
    
    
}
