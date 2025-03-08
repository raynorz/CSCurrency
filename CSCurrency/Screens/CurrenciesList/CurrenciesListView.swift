//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct CurrenciesListView: View {
    @ObservedObject private var viewModel: CurrenciesListViewModel
    
    init() {
        let currencyService = CurrencyService(apiManager: MockAPIManager()) // TODO: change to backendCommunication
        let useCase = GetCurrenciesUseCase(service: currencyService)
        self.viewModel = CurrenciesListViewModel(getCurrenciesUseCase: useCase)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.currencies, id: \.id) { currency in
                Text(currency.name)
            }
        }
        .onAppear {
            Task {
                await viewModel.getCurrencies()
            }
        }
    }
}

#Preview {
    CurrenciesListView()
}
