//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct CurrencyResponse: Codable {
    let country, name, shortName: String
    let amount: Int
    let validFrom: String
    let valBuy: Int
    let valSell, valMid: Double
    let currBuy: Int
    let currSell, currMid, move, cnbMid: Double
    let version: Int
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
