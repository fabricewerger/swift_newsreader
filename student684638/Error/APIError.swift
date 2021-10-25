//
//  APIError.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Fout met het decoden"
        case .errorCode(let code):
            return "Error \(code) - Er is iets fout gegaan"
        case .unknown:
            return "Onbekende error"
        }
    }
}
