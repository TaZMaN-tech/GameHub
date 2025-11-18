//
//  RAWGEndpoint..swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

enum RAWGEndpoint: Endpoint {
    
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case trending(page: Int)
    
    
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = RAWGConfig.baseURL.scheme
        components.host = RAWGConfig.baseURL.host
        components.path = RAWGConfig.baseURL.path + path
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: RAWGConfig.apiKey),
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        queryItems.append(contentsOf: extraQueryItems)
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    private var path: String {
        switch self {
        case .popular,
                .topRated,
                .upcoming,
                .trending:
            return "/games"
        }
    }
    
    private var page: Int {
        switch self {
        case .popular(page: let page),
                .topRated(page: let page),
                .upcoming(page: let page),
                .trending(page: let page):
            return page
        }
    }
    
    private var extraQueryItems: [URLQueryItem] {
        switch self {
        case .popular:
            return [URLQueryItem(name: "ordering", value: "-added")]
        case .topRated:
            return [URLQueryItem(name: "ordering", value: "-rating")]
        case .upcoming:
            return [URLQueryItem(name: "dates", value: "2025-01-01,2025-12-31"),
                    URLQueryItem(name: "ordering", value: "-added")]
        case .trending:
            return [URLQueryItem(name: "ordering", value: "-metacritic")]
        }
    }
}
