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
        let currencyService = CurrencyService(apiManager: BackendCommunication())
        let useCase = GetCurrenciesUseCase(service: currencyService)
        self.viewModel = CurrenciesListViewModel(getCurrenciesUseCase: useCase)
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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
