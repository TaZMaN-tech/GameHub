//
//  Endpoint.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

protocol Endpoint {
    var urlRequest: URLRequest? { get }
}

struct RAWGConfig {
    static let baseURL = URL(string: "https://api.rawg.io/api")!
}
