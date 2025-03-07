//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct ContentView: View {
    private let currencyService: CurrencyServiceProtocol
    private let useCase: GetCurrenciesUseCase
    
    
    init() {
        self.currencyService = CurrencyService(apiManager: BackendCommunication())
        self.useCase = GetCurrenciesUseCase(service: currencyService)
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
                do {
                    let response = try await useCase.getCurrencies()
                    print(response)
                } catch {
                    print("Catching error: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
