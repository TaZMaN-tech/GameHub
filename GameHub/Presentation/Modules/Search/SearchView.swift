//
//   SearchView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    
    let backgroundView = GradientBackgroundView()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите название игры"
        label.textAlignment = .center
        label.textColor = .textSecondary
        label.numberOfLines = 0
        return label
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(backgroundView)
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(emptyLabel)
        addSubview(loadingIndicator)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchBar.placeholder = "Поиск игр..."
        searchBar.searchBarStyle = .minimal
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
            emptyLabel.isHidden = true
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func showEmptyState(_ isEmpty: Bool, hasSearchText: Bool) {
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
        
        if isEmpty {
            emptyLabel.text = hasSearchText ? "Ничего не найдено" : "Введите название игры"
        }
    }
}
