//
//  NetworkService.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

protocol NetworkServicing {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServicing {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {
        guard let request = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
        } catch {
            throw NetworkError.transport(error)
        }
    }
    
    
}
