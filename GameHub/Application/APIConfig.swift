//
//  APIConfig.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 22.11.2025.
//

import Foundation

enum APIConfig {
    static var rawgKey: String {
        Bundle.main.object(forInfoDictionaryKey: "RAWG_API_KEY") as? String ?? ""
    }
}
