//
//  HomeSectionHeaderView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit
import SnapKit

final class HomeSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "HomeSectionHeaderView"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .label
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
