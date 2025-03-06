//
//  BackendCommunication.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

final class BackendCommunication {
    private var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    func request<T: Decodable>(endpoint: APIRequestConvertible) async throws -> T {
        do {
            let urlRequest = try endpoint.createUrlRequest()
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
