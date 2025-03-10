//
//  Image+Ext.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 08.03.2025.
//

import SwiftUI

extension Image {
    init(systemImageName: SystemImage) {
        self.init(systemName: systemImageName.rawValue)
    }
}
