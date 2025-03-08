//
//  CurrencyDataProtocol.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

protocol CurrencyDataProtocol: Identifiable {
    var id: String { get }
    var name: String { get }
    var shortName: String { get }
    var country: String { get }
    var amount: Int { get }
    var valMid: Double { get }
    var valueFormatted: String { get }
    var move: Double { get }
}

extension CurrencyResponse: CurrencyDataProtocol {
    var id: String {
        country
    }
    
    var valueFormatted: String {
        String(format: "%.3f", valMid)
    }
}
