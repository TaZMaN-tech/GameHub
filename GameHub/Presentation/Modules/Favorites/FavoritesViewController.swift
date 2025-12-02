//
//  FavoritesViewController.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class FavoritesViewController: UIViewController, FavoritesViewInput {
    
    var output: FavoritesViewOutput?
    
    private let contentView = FavoritesView()
    private var items: [FavoriteGameViewModel] = []
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.Favorites.title
        setupTable()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    private func setupTable() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(FavoriteGameCell.self, forCellReuseIdentifier: FavoriteGameCell.reuseIdentifier)
    }
    
    func display(games: [FavoriteGameViewModel]) {
        self.items = games
        contentView.tableView.reloadData()
    }
    
    func showEmptyState(_ isEmpty: Bool) {
        contentView.setEmptyState(isEmpty)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGameCell.reuseIdentifier,
                                                       for: indexPath) as? FavoriteGameCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Strings.Favorites.deleteAction) { [weak self] _, _, completion in
            self?.output?.didDeleteRow(at: indexPath.row)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
