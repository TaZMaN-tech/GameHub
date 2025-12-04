//
//  SearchPresenter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import Foundation

final class SearchPresenter {
    
    private weak var view: SearchViewInput?
    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput
    
    private var games: [Game] = []
    private var debounceWorkItem: DispatchWorkItem?
    
    init(
        view: SearchViewInput,
        interactor: SearchInteractorInput,
        router: SearchRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func makeViewModels(from games: [Game]) -> [SearchGameViewModel] {
        games.map { game in
            SearchGameViewModel(
                title: game.name,
                subtitle: "\(game.genre) • \(game.formattedRating)",
                imageURL: game.backgroundImageURL
            )
        }
    }
}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    
    func viewDidLoad() {
        view?.showEmptyState(true)
    }
    
    func didChangeSearchText(_ text: String) {
        // Отменяем предыдущий отложенный запрос
        debounceWorkItem?.cancel()
        
        // Если текст пустой — сразу показываем пустое состояние
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            interactor.cancelSearch()
            games = []
            view?.display(games: [])
            view?.showEmptyState(true)
            return
        }
        
        // Debounce: ждём 0.5 секунды перед запросом
        let workItem = DispatchWorkItem { [weak self] in
            self?.view?.showLoading(true)
            self?.interactor.searchGames(query: text)
        }
        
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    func didSelectGame(at index: Int) {
        guard index < games.count else { return }
        router.routeToGameDetails(games[index])
    }
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    
    func didFind(games: [Game]) {
        self.games = games
        let viewModels = makeViewModels(from: games)
        
        view?.showLoading(false)
        view?.display(games: viewModels)
        view?.showEmptyState(games.isEmpty)
    }
    
    func didFailWithError(_ error: Error) {
        view?.showLoading(false)
        
        if let networkError = error as? NetworkError {
            view?.showError(networkError.userMessage)
        } else {
            view?.showError("Не удалось выполнить поиск")
        }
    }
}
