//
//  APIRequestConvertible+Ext.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

extension APIRequestConvertible {
    var fileName: String {
        httpMethod.rawValue + "-" + path.replacingOccurrences(of: "/", with: "-")
    }
}
