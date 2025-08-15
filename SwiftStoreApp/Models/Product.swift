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
    var image: String
    
    init(id: Int, title: String, description: String, category: String, price: Double, shippingInformation: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.shippingInformation = shippingInformation
        self.image = image
    }
    
    static func numberFormattedToString(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? "00.00"
    }

}

