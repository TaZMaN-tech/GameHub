//
//  NetworkError.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
    case transport(Error)
}

extension NetworkError {
    var userMessage: String {
        switch self {
        case .invalidURL:
            return "Неверный адрес сервера."
        case .invalidResponse:
            return "Сервер вернул некорректный ответ."
        case .statusCode(let code):
            return "Ошибка сервера (\(code)). Попробуйте позже."
        case .decoding:
            return "Не удалось обработать данные от сервера."
        case .transport(let error):
            return "Проблема с сетью: \(error.localizedDescription)"
        }
    }
}
