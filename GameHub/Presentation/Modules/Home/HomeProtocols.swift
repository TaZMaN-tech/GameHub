//
//  HomeProtocols.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 16.11.2025.
//

import UIKit

// MARK: - View

protocol HomeViewInput: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func display(sections: [HomeSectionViewModel])
}

protocol HomeViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func didTapRetry()
}

// MARK: - Interactor

protocol HomeInteractorInput: AnyObject {
    func loadInitialData()
}

protocol HomeInteractorOutput: AnyObject {
    func didLoad(sections: [HomeSection])
    func didFailLoading(_ error: Error)
}

// MARK: - Router

protocol HomeRouterInput: AnyObject {
    func openDetails(for game: Game)
}
