//
//  NumberFormatter.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 19/08/25.
//

import Foundation

enum Formatters {
    static let paraRealBrasileiro: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        return formatter //insano igual no uikit
    }()
    
    static let paraDolarAmericano: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
    
}

