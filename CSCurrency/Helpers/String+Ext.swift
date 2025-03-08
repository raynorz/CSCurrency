//
//  String+Ext.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import Foundation

extension String {
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        return formatter.number(from: self)?.doubleValue
    }
}
