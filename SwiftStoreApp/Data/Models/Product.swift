//
//  Product.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation
import SwiftData

struct ProductsResponse: Decodable {
    var products: [Product]
}

class Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var shippingInformation: String
    var thumbnail: String
    var quantity: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, category, price, shippingInformation, thumbnail
    }
    
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
