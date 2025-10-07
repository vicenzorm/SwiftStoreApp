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
    
    init(id: Int, title: String, description: String, category: String, price: Double, shippingInformation: String, thumbnail: String, quantity: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.shippingInformation = shippingInformation
        self.thumbnail = thumbnail
        self.quantity = quantity
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(String.self, forKey: .category)
        self.price = try container.decode(Double.self, forKey: .price)
        self.shippingInformation = try container.decode(String.self, forKey: .shippingInformation)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
    
    
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
