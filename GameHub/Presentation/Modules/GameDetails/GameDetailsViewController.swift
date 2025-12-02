//
//  GameDetailsViewController.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class GameDetailsViewController: UIViewController, GameDetailsViewInput {
    
    var output: GameDetailsViewOutput?
    
    private let contentView = GameDetailsView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = favoriteButton
        
    }
    
    @objc private func favoriteTapped() {
        output?.didTapFavorite()
    }
    
    // MARK: - GameDetailsViewInput
    
    func display(viewModel: GameDetailsViewModel) {
        title = viewModel.title
        contentView.configure(with: viewModel)
        updateFavorite(isFavorite: viewModel.isFavorite)
    }
    
    func updateFavorite(isFavorite: Bool) {
        let imageName = isFavorite ? "star.fill" : "star"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}
