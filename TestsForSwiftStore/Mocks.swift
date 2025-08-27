//
//  Mocks.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Foundation

enum Mocks {
    case iphone
    
    var mockado: Product {
        
        switch self {
        case .iphone:
            return Product(
                id: 0,
                title: "Title",
                description: "Description",
                category: "Category",
                price: 20.00,
                shippingInformation: "Never",
                thumbnail: "thumbnail",
                quantity: 1
            )
            
        }
    }
}
