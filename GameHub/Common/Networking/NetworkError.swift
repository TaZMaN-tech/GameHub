//
//  NetworkError.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation
 
enum NetworkError: Error {
    case invalidURL
    case transport(Error)
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Некорректный URL"
        case .transport(let error):
            return "Сетевая ошибка: \(error.localizedDescription)"
        case .invalidResponse:
            return "Некорректный ответ сервера"
        case .statusCode(let code):
            return "Сервер вернул статус-код \(code)"
        case .decoding(let error):
            return "Ошибка декодирования: \(error.localizedDescription)"
        }
    }
}
