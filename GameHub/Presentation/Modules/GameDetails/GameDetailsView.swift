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
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let genreLabel = UILabel()
    let ratingLabel = UILabel()
    
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
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        genreLabel.font = .systemFont(ofSize: 16, weight: .medium)
        genreLabel.textColor = .white.withAlphaComponent(0.9)
        
        ratingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingLabel.textColor = .systemYellow
        
        contentStack.addArrangedSubview(posterImageView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(genreLabel)
        contentStack.addArrangedSubview(ratingLabel)
    }
}
