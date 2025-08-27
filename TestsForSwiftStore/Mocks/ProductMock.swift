//
//  Mocks.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Foundation
@testable import SwiftStoreApp

enum ProductMock {
    case iphone, macbookAir, produtoComNomeMuitoLongo, produtoComNomeMuitoCurto
    
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
            
        case .macbookAir:
            return Product(
                id: 1,
                title: "Title",
                description: "Description",
                category: "Category",
                price: 20.00,
                shippingInformation: "Never",
                thumbnail: "thumbnail",
                quantity: 1
            )
                    
        case .produtoComNomeMuitoLongo:
            return Product(
                id: 2,
                title: "Title",
                description: "Description",
                category: "Category",
                price: 20.00,
                shippingInformation: "Never",
                thumbnail: "thumbnail",
                quantity: 1
            )
                    
        case .produtoComNomeMuitoCurto:
            return Product(
                id: 3,
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
