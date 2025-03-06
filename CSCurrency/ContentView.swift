//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct ContentView: View {
    private let currencyService: CurrencyServiceProtocol = CurrencyService(apiManager: BackendCommunication())
    
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
                    let response = try await currencyService.getCurrenciesExchange()
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
