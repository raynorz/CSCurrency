//
//  ErrorAlertType.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

enum ErrorAlertType: Identifiable {
    case networkingError
    
    var title: String {
        switch self {
        case .networkingError:
            return "Networking error"
        }
    }
    
    var description: String {
        switch self {
        case .networkingError:
            return "Something went wrong. Please try again later."
        }
    }
    
    var id: String {
        title
    }
}
