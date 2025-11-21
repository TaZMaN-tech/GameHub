//
//   HomePresenter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput
    
    private var sections: [HomeSection] = []
    
    init(interactor: HomeInteractorInput, router: HomeRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func makeViewModels(from sections: [HomeSection]) -> [HomeSectionViewModel] {
        sections.map { section in
            let items = section.games.map {
                GameItemViewModel(
                    title: $0.name,
                    subtitle: $0.genre,
                    imageURL: $0.backgroundImageURL
                )
            }
            return HomeSectionViewModel(
                type: section.type,
                title: section.title,
                items: items
            )
        }
    }
}

extension HomePresenter: HomeViewOutput {
    
    func viewDidLoad() {
        view?.showLoading(true)
        interactor.loadInitialData()
    }
    
    func didTapRetry() {
        view?.showLoading(true)
        interactor.loadInitialData()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.section < sections.count else { return }
        let section = sections[indexPath.section]
        guard indexPath.row < section.games.count else { return }
        let game = section.games[indexPath.row]
        router.routeToGameDetails(game)
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func didLoad(sections: [HomeSection]) {
        self.sections = sections
        let viewModels = makeViewModels(from: sections)
        view?.showLoading(false)
        view?.display(sections: viewModels)
    }
    
    func didFailLoading(_ error: any Error) {
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }
}
