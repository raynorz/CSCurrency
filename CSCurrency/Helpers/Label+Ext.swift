//
//  Label+Ext.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(text: String, systemImageName: SystemImage) {
        self.init {
            Text(text)
        } icon: {
            Image(systemName: systemImageName.rawValue)
        }
    }
}
