//
//  HomeViewController.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewInput {
    
    var output: HomeViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "GameHub"
        
        output?.viewDidLoad()
    }
    
    func showLoading(_ isLoading: Bool) {
        
    }
    
    func showError(_ message: String) {
        
    }
}
