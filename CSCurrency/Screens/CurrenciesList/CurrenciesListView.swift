//
//  ContentView.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import SwiftUI

struct CurrenciesListView: View {
    @ObservedObject private var viewModel: CurrenciesListViewModel
    @FocusState private var isInputFocused: Bool
    
    init() {
        let currencyService = CurrencyService(apiManager: BackendCommunication())
        let useCase = GetCurrenciesUseCase(service: currencyService)
        self.viewModel = CurrenciesListViewModel(getCurrenciesUseCase: useCase)
    }
    
    var body: some View {
        List {
            textfield
            listContent
        }
        .scrollContentBackground(.hidden)
        .background(Color.systemBackground)
        .alert(item: $viewModel.alertType) { item in
            Alert(title: Text(item.title), message: Text(item.description))
        }
        .onAppear {
            Task {
                await viewModel.getCurrencies()
            }
        }
    }
}

// MARK: - Private subviews
private extension CurrenciesListView {
    private var textfield: some View {
        HStack(spacing: 8) {
            CurrencyCircle(shortName: "CZK")
            
            Spacer()
            
            TextField("Amount", text: $viewModel.amountInput)
                .focused($isInputFocused)
                .keyboardType(.decimalPad)
            
            Button {
                isInputFocused = false
            } label: {
                Image(systemImageName: .arrowRightCircleFill)
                    .font(.title2)
                    .foregroundColor(.systemTeal)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.systemBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.systemGray, lineWidth: 1)
        )
    }
    
    private var listContent: some View {
        ForEach(viewModel.currencies, id: \.id) { currency in
            CurrencyRow(currency: currency, basicAmount: viewModel.baseCurrencyAmount)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.systemBackground.opacity(0))
    }
}

#Preview {
    CurrenciesListView()
}
