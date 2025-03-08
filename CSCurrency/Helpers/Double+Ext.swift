//
//  Double+Ext.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import Foundation

extension Double {
    var currencyValueFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%.3f", self)
    }
}
