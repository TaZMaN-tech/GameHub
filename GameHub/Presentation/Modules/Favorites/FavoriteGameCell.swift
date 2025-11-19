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
            make.edges.equalToSuperview().inset(12)
        }
        
        container.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        container.layer.cornerRadius = 18
        container.layer.masksToBounds = true
        
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 14
        iconView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)
        
        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalToSuperview().inset(12)
        }
        
        subtitleLabel.snp.makeConstraints { make in
              make.top.equalTo(titleLabel.snp.bottom).offset(4)
              make.left.equalTo(iconView.snp.right).offset(12)
              make.right.equalToSuperview().inset(12)
              make.bottom.equalToSuperview().inset(12)
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
