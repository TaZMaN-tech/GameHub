//
//  Strings.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 02.12.2025.
//

import Foundation

enum Strings {
    enum Favorites {
        static let title = "Избранное"
        static let deleteAction = "Удалить"
        static let emptyState = "Нет избранных игр"
    }
    
    enum Home {
        static let title = "GameHub"
        static let retryButton = "Повторить"
        static let cancelButton = "Отмена"
        static let errorTitle = "Не удалось загрузить игры"
    }
    
    enum Sections {
        static let popular = "Популярное"
        static let topRated = "Топ по рейтингу"
        static let upcoming = "Скоро выйдет"
    }
    
    enum Search {
        static let title = "Поиск"
    }
}
