//
//  BackendCommunication.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

enum NetworkingError: Error {
    case invalidURLRequest
    case invalidResponse
    case serializationError
    case notFound
}

class CustomJSONDecoder: JSONDecoder, @unchecked Sendable {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}

final class BackendCommunication {
    private var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    func request<T: Decodable>(endpoint: String) async throws -> T {
        do {
            let urlRequest = URLRequest(url: URL(string: endpoint)!)
            let (data, response) = try await session.data(for: urlRequest)
            
            return try handleResponse(data: data, response: response)
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.invalidURLRequest
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else { throw NetworkingError.invalidResponse }
        
        switch response.statusCode {
        case 200...299:
            do {
                return try CustomJSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkingError.serializationError
            }
        default:
            throw NetworkingError.notFound
        }
    }
}
