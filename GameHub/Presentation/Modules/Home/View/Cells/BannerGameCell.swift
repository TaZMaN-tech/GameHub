//
//  BannerGameCell.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit
import SnapKit

final class BannerGameCell: UICollectionViewCell {
    static let reuseIdentifier = "BannerGameCell"
    
    private let imageView = UIImageView()
    private let overlayView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.textColor = .white.withAlphaComponent(0.8)
        
        contentView.addSubview(imageView)
        imageView.addSubview(overlayView)
        overlayView.addSubview(titleLabel)
        overlayView.addSubview(subtitleLabel)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-4)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with viewModel: GameItemViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
