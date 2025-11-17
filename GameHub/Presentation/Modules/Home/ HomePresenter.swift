//
//   HomePresenter.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

final class HomePresenter {
    
    weak var view: HomeViewInput?
    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput
    
    init(interactor: HomeInteractorInput, router: HomeRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeViewOutput {
    
    func viewDidLoad() {
        view?.showLoading(true)
        interactor.loadInitialData()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func didLoadData() {
        view?.showLoading(false)
    }
    
    func didFailLoading(_ error: any Error) {
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }
}
