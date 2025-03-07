//
//  CurrencyDataProtocol.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

protocol CurrencyDataProtocol {
    var name: String { get }
    var country: String { get }
    var amount: Int { get }
}

extension CurrencyResponse: CurrencyDataProtocol { }
