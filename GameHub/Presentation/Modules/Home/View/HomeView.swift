//
//  HomeView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    
    let collectionView: UICollectionView
    let backgroundView = GradientBackgroundView()
    
    init(layout: UICollectionViewLayout) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(backgroundView)
        addSubview(collectionView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
