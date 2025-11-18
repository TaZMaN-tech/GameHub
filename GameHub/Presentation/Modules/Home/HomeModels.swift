//
//  HomeModels.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

enum HomeSectionType {
    case banner
    case horizontal
}

struct HomeSection {
    let type: HomeSectionType
    let title: String?
    let games: [Game]
}

struct GameItemViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
}

struct HomeSectionViewModel {
    let type: HomeSectionType
    let title: String?
    let items: [GameItemViewModel]
}
