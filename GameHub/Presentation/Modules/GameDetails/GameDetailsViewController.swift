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
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func display(viewModel: GameDetailsViewModel) {
        title = viewModel.title
        contentView.titleLabel.text = viewModel.title
        contentView.genreLabel.text = viewModel.genre
        contentView.ratingLabel.text = "Rating: \(viewModel.ratingText)"
        
        contentView.posterImageView.image = nil

        if let url = viewModel.imageURL {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                self?.contentView.posterImageView.image = image
            }
        }
    }
}
