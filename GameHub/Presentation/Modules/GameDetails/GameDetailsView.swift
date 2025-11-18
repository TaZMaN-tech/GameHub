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
        
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        genreLabel.font = .systemFont(ofSize: 16, weight: .medium)
        genreLabel.textColor = .white.withAlphaComponent(0.9)
        
        ratingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingLabel.textColor = .systemYellow
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(genreLabel)
        contentStack.addArrangedSubview(ratingLabel)
    }
}
