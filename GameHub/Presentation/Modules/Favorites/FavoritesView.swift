//
//  FavoritesView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit
import SnapKit

final class FavoritesView: UIView {
    
    let backGroundView = GradientBackgroundView()
    let tableView = UITableView(frame: .zero, style: .plain)
    private let emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(backGroundView)
        backGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyLabel.text = "No favorite games yet"
        emptyLabel.textColor = .white.withAlphaComponent(0.9)
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.isHidden = true
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    func setEmptyState(_ isEmpty: Bool) {
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
}
