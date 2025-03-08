//
//  CurrencyRow.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: any CurrencyDataProtocol
    
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
    
    private var headerView: some View {
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
    
    private var conversionView: some View {
        HStack {
            Text("CZK 1")
                .font(.subheadline)
                .foregroundColor(.label)
            
            Spacer()
            
            Image(systemImageName: .arrowRight)
                .foregroundColor(.label)
            
            Spacer()
            
            HStack {
                Image(systemImageName: arrowDirectionImage)
                Text("\(currency.shortName) \(currency.valueFormatted)")
            }
            .foregroundStyle(valueColor)
            .font(.subheadline)
            .fontWeight(.bold)
        }
        .font(.subheadline)
    }
    
    private var arrowDirectionImage: SystemImage {
        switch currency.move {
        case let x where x < 0:
            return .arrowDownRightCircle
        case let x where x > 0:
            return .arrowUpRightCircle
        default:
            return .arrowRightCircle
        }
    }
    
    private var valueColor: Color {
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
