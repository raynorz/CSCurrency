//
//  CurrencyCircle.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import SwiftUI

struct CurrencyCircle: View {
    private let shortName: String
    private let backgroundColor: Color
    
    init(shortName: String, backgroundColor: Color = .blue) {
        self.shortName = shortName
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(shortName)
            .font(.footnote)
            .frame(width: 32, height: 32)
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(backgroundColor.gradient)
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.systemGray3, lineWidth: 1)
            )
    }
}

#Preview {
    CurrencyCircle(shortName: "CZK")
}
