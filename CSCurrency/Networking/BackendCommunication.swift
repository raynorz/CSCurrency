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
            var urlRequest = URLRequest(url: URL(string: endpoint)!)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("9a25846c-918e-4bae-865c-3c992df79ff7", forHTTPHeaderField: "WEB-API-key")
            let (data, response) = try await session.data(for: urlRequest)
            
            return try handleResponse(data: data, urlData: (urlRequest, response))
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.invalidURLRequest
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, urlData: (request: URLRequest, response: URLResponse)) throws -> T {
        guard let response = urlData.response as? HTTPURLResponse else { throw NetworkingError.invalidResponse }
        
        
        debugPrint("➡️ URL: \(String(describing: urlData.request.url?.absoluteString))")
        debugPrint("🔢Status code: \(response.statusCode)")
        debugPrint("✉️ SERVER RESPONSE:", String(decoding: data, as: UTF8.self))
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
