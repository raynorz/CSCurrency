//
//  CurrencyRouter.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

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
