//
//  FavoriteGameCell.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit
import SnapKit

final class FavoriteGameCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteGameCell"
    
    private let container = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var currentURL: URL?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        container.backgroundColor = .cardBackground
        container.layer.cornerRadius = 18
        container.layer.masksToBounds = true
        
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 14
        iconView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .textPrimary
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .textSecondary
        
        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalToSuperview().inset(12)
        }
        
        subtitleLabel.snp.makeConstraints { make in
              make.top.equalTo(titleLabel.snp.bottom).offset(6)
              make.left.equalTo(iconView.snp.right).offset(12)
              make.right.equalToSuperview().inset(12)
              make.bottom.equalToSuperview().inset(16)
          }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        subtitleLabel.text = nil
    }
    
    func configure(with viewModel: FavoriteGameViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        iconView.image = UIImage(systemName: "gamecontroller")
        
        guard let url = viewModel.imageURL else { return }
        currentURL = url
        
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            guard let self, self.currentURL == url else { return }
            self.iconView.image = image ?? UIImage(systemName: "gamecontroller")
        }
        
    }
}
