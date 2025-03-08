//
//  GetCurrenciesUseCase.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

import Foundation

protocol GetCurrenciesUseCaseProtocol {
    func getCurrencies() async throws -> [any CurrencyDataProtocol]
}

struct GetCurrenciesUseCase: GetCurrenciesUseCaseProtocol {
    private let service: CurrencyServiceProtocol
    
    init(service: CurrencyServiceProtocol) {
        self.service = service
    }
}

extension GetCurrenciesUseCase {
    func getCurrencies() async throws -> [any CurrencyDataProtocol] {
        let allCurrencies = try await service.getCurrenciesExchange()
        
        return allCurrencies.filter { $0.valMid > 0}
    }
}
