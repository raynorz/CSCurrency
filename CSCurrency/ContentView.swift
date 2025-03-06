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

enum CurrencyRouter: APIRequestConvertible {
    case listOfRates
}

extension CurrencyRouter {
    var path: String {
        switch self {
        case .listOfRates:
            return "rates/exchangerates"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .listOfRates:
            return .get
        }
    }
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
                    let response: [CurrencyResponse] = try await apiManager.request(endpoint: CurrencyRouter.listOfRates)
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
