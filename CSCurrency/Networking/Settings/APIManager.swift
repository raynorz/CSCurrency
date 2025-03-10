//
//  APIManager.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

protocol APIManager {
    func request<T: Decodable>(endpoint: APIRequestConvertible) async throws -> T
}
