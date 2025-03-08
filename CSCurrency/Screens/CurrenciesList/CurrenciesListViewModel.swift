//
//  CurrenciesListViewModel.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

import Foundation

@MainActor
final class CurrenciesListViewModel: ObservableObject {
    private let getCurrenciesUseCase: GetCurrenciesUseCaseProtocol
    
    @Published private(set) var currencies: [any CurrencyDataProtocol] = []
    @Published var alertType: ErrorAlertType?
    @Published var amountInput: String = "1"

    init(getCurrenciesUseCase: GetCurrenciesUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }
}

// MARK: - Public properties
extension CurrenciesListViewModel {
    var baseCurrencyAmount: Double {
        amountInput.doubleValue ?? 0.0
    }
}

// MARK: - Public methods
extension CurrenciesListViewModel {
    func getCurrencies() async {
        do {
            currencies = try await getCurrenciesUseCase.getCurrencies()
            print(currencies)
        } catch {
            alertType = .networkingError
            print("Error: \(error)")
        }
    }
}
