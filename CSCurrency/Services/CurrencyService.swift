//
//  CurrencyService.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

final class CurrencyService {
    private let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
}

extension CurrencyService {
    func getCurrenciesExchange() async throws -> [CurrencyResponse] {
        try await apiManager.request(endpoint: CurrencyRouter.listOfRates)
    }
}
