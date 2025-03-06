//
//  NetworkingErr.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

enum NetworkingError: Error {
    case invalidURLRequest
    case invalidResponse
    case serializationError
    case notFound
    case other(Error)
    
    var description: String {
        switch self {
        case .invalidURLRequest:
            return "#invalidURLRequest"
        case .invalidResponse:
            return "#invalidResponse"
        case .serializationError:
            return "#serializationError"
        case .notFound:
            return "notFound"
        case .other(let err):
            return err.localizedDescription
        }
    }
    
    static func map(_ error: Error) -> NetworkingError {
        return (error as? NetworkingError) ?? .other(error)
    }
}
