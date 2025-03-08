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

    init(getCurrenciesUseCase: GetCurrenciesUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
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
