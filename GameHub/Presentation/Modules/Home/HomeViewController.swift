//
//  HomeViewController.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewInput {
    
    var output: HomeViewOutput?
    
    private lazy var contentView = HomeView(layout: createLayout())
    private var sections: [HomeSectionViewModel] = []
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollection()
        
        output?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "GameHub"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollection() {
        let contentView = contentView.collectionView
        
        contentView.dataSource = self
        contentView.delegate = self
        
        contentView.register(BannerGameCell.self, forCellWithReuseIdentifier: BannerGameCell.reuseIdentifier)
        contentView.register(GameHorizontalCell.self, forCellWithReuseIdentifier: GameHorizontalCell.reuseIdentifier)
        contentView.register(HomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self, sectionIndex < self.sections.count else { return nil }
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case .banner:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(260)
                    ),
                    subitems: [item]
                )
                
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .none
                return sectionLayout
                
            case .horizontal:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .absolute(180),
                        heightDimension: .estimated(230)
                    ),
                    subitems: [item]
                )
                
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .continuous
                sectionLayout.interGroupSpacing = 12
                
                // Хэдер
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                sectionLayout.boundarySupplementaryItems = [header]
                sectionLayout.contentInsets = .init(top: 0, leading: 16, bottom: 24, trailing: 16)
                
                return sectionLayout
            }
        }
        return layout
    }
    
    func showLoading(_ isLoading: Bool) {
        
    }
    
    func showError(_ message: String) {
        print("Home error:", message)
    }
    
    func display(sections: [HomeSectionViewModel]) {
        self.sections = sections
        contentView.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.item]
        
        switch section.type {
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerGameCell.reuseIdentifier, for: indexPath) as? BannerGameCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: item)
            return cell
        case .horizontal:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameHorizontalCell.reuseIdentifier, for: indexPath) as? GameHorizontalCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        
        guard section.type == .horizontal, kind == UICollectionView.elementKindSectionHeader, let title = section.title else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeaderView.reuseIdentifier, for: indexPath) as? HomeSectionHeaderView else {
            return UICollectionReusableView()
        }
        header.configure(title: title)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectItem(at: indexPath)
    }
    
}
