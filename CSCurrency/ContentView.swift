//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct CurrencyResponse: Codable {
    let shortName: String
    let validFrom: String
    let name, country: String
    let move: Double
    let amount: Int
    let valBuy, valSell, valMid, currBuy: Double
    let currSell, currMid: Double
    let version: Int
    let cnbMid, ecbMid: Double
}

struct ContentView: View {
    private let apiManager = BackendCommunication()
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
                    let response: [CurrencyResponse] = try await apiManager.request(endpoint: "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v2/rates/exchangerates")
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
