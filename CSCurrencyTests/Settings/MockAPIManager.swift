//
//  MockAPIManager.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

final class MockAPIManager: APIManager {
    func request<T>(endpoint: any APIRequestConvertible) async throws -> T where T : Decodable {
        do {
            let data: T = try JSONLoader().loadJSON(fileName: endpoint.fileName)
            return data
        } catch {
            throw NetworkingError.invalidResponse
        }
    }
}
