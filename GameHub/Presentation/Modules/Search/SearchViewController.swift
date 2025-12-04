//
//  SearchViewController.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 04.12.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var output: SearchViewOutput?
    
    private let contentView = SearchView()
    private var items: [SearchGameViewModel] = []
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Поиск"
        setupTableView()
        setupSearchBar()
        output?.viewDidLoad()
    }
    
    func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(
            FavoriteGameCell.self,
            forCellReuseIdentifier: FavoriteGameCell.reuseIdentifier
        )
    }
    
    private func setupSearchBar() {
        contentView.searchBar.delegate = self
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    
    func showLoading(_ isLoading: Bool) {
        contentView.showLoading(isLoading)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func display(games: [SearchGameViewModel]) {
        self.items = games
        contentView.tableView.reloadData()
    }
    
    func showEmptyState(_ isEmpty: Bool) {
        let hasText = !(contentView.searchBar.text?.isEmpty ?? true)
        contentView.showEmptyState(isEmpty, hasSearchText: hasText)
    }
}

// MARK: - UITableViewDataSource & Delegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteGameCell.reuseIdentifier,
            for: indexPath
        ) as? FavoriteGameCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        // Конвертируем SearchGameViewModel в FavoriteGameViewModel
        let viewModel = FavoriteGameViewModel(
            title: item.title,
            subtitle: item.subtitle,
            imageURL: item.imageURL
        )
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.didSelectGame(at: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.didChangeSearchText(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()  // Скрываем клавиатуру
    }
}
