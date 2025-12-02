//
//  GameDetailsView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit
import SnapKit

final class GameDetailsView: UIView {
    
    let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    let backgroundView = GradientBackgroundView()
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    private let ratingLabel = UILabel()
    
    private var currentImageURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(backgroundView)
        addSubview(scrollView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        contentStack.axis = .vertical
        contentStack.spacing = 12
        
        scrollView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 20
        posterImageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(posterImageView.snp.width).multipliedBy(9.0/16.0)
        }
        
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = .textPrimary
        titleLabel.numberOfLines = 0
        
        genreLabel.font = .systemFont(ofSize: 16, weight: .medium)
        genreLabel.textColor = .textSecondary
        
        ratingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingLabel.textColor = .textAccent
        
        contentStack.addArrangedSubview(posterImageView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(genreLabel)
        contentStack.addArrangedSubview(ratingLabel)
    }
    
    func configure(with viewModel: GameDetailsViewModel) {
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        ratingLabel.text = viewModel.ratingText
        
        posterImageView.image = nil
        
        guard let url = viewModel.imageURL else { return }
        currentImageURL = url
        
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            guard let self, self.currentImageURL == url else { return }
            self.posterImageView.image = image
        }
    }
}
