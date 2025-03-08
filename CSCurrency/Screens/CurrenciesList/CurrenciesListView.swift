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
                HStack {
                    VStack(alignment: .leading) {
                        Text(currency.shortName)
                            .font(.headline)
                        Text(currency.name)
                            .font(.subheadline)
                        Text(currency.country)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()

                    VStack(alignment: .trailing) {
                        Text(String(format: "%.3f", currency.valMid))
                            .font(.headline)
                        Text("\(String(format: "%.2f", currency.move))")
                            .font(.caption)
                            .foregroundColor(currency.move < 0 ? .red : .green)
                    }
                }
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
