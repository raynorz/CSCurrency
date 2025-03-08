//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct CurrencyCircle: View {
    private let shortName: String
    private let backgroundColor: Color
    
    init(shortName: String, backgroundColor: Color = .blue) {
        self.shortName = shortName
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(shortName)
            .font(.footnote)
            .frame(width: 32, height: 32)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(backgroundColor.gradient)
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct CurrencyRow: View {
    var currency: any CurrencyDataProtocol
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    HStack(spacing: -10) {
                        CurrencyCircle(shortName: "CZK")
                        CurrencyCircle(shortName: currency.shortName, backgroundColor: .orange)
                    }
                    
                    Text("CZK / \(currency.shortName)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                HStack {
                    Text("CZK 1")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemImageName: .arrowRight)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Label(text: "\(currency.shortName) \(currency.valueFormatted)", systemImageName: SystemImage.arrowUpRightCircle)
                }
                .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.7))
        )
    }
}

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
                CurrencyRow(currency: currency)
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
