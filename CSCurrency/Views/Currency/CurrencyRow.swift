//
//  CurrencyRow.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: any CurrencyDataProtocol
    var basicAmount: Double = 1
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                headerView
                conversionView
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
    }
}

// MARK: - Private subviews
private extension CurrencyRow {
    var headerView: some View {
        HStack {
            HStack(spacing: -10) {
                CurrencyCircle(shortName: "CZK")
                CurrencyCircle(shortName: currency.shortName, backgroundColor: .orange)
            }
            
            Text("CZK / \(currency.shortName)")
                .font(.headline)
                .foregroundColor(.label)
            
            Spacer()
        }
    }
    
    var conversionView: some View {
        HStack {
            HStack {
                Text("CZK \(domesticCurrencyAmount.currencyValueFormatted)")
                Image(systemImageName: arrowDirectionImage)
            }
            .foregroundStyle(valueColor)
            .font(.subheadline)
            .fontWeight(.bold)
            
            Spacer()
            
            Image(systemImageName: .arrowRight)
                .foregroundColor(.label)
            
            Spacer()
            
            Text("\(currency.shortName) \(basicAmount.currencyValueFormatted)")
                .foregroundStyle(Color.label)
                .font(.subheadline)
        }
        .font(.subheadline)
    }
}

// MARK: - Private properties
private extension CurrencyRow {
    var domesticCurrencyAmount: Double {
        currency.valMid * basicAmount
    }
    
    var arrowDirectionImage: SystemImage {
        switch currency.move {
        case let x where x < 0:
            return .arrowDownRightCircle
        case let x where x > 0:
            return .arrowUpRightCircle
        default:
            return .arrowRightCircle
        }
    }
    
    var valueColor: Color {
        switch currency.move {
        case let x where x < 0:
            return .systemRed
        case let x where x > 0:
            return .systemGreen
        default:
            return .label
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static let currencies: [CurrencyResponse]? = JSONLoader().getExample(request: CurrencyRouter.listOfRates)
    static var previews: some View {
        CurrencyRow(currency: currencies!.first!)
    }
}
