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