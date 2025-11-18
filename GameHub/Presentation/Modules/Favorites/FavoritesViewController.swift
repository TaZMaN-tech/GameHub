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
        title = "Избранное"
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
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func display(games: [FavoriteGameViewModel]) {
        self.items = games
        contentView.tableView.reloadData()
    }
    
    func showEmptyState(_ isEmpty: Bool) {
        contentView.setEmptyState(isEmpty)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = viewModel.title
        config.secondaryText = viewModel.subtitle
        cell.contentConfiguration = config
        cell.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.output?.didDeleteRow(at: indexPath.row)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
