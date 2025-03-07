//
//  GetCurrenciesUseCase.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

import Foundation

struct GetCurrenciesUseCase {
    private let service: CurrencyServiceProtocol
    
    init(service: CurrencyServiceProtocol) {
        self.service = service
    }
}

extension GetCurrenciesUseCase {
    func getCurrencies() async throws -> [CurrencyResponse] {
        return try await service.getCurrenciesExchange()
    }
}
