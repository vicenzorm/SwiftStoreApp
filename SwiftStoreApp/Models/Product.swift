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

@Model
class Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var productDescription: String
    var category: String
    var price: Double
    var shippingInformation: String
    var image: String
    var isFavorite: Bool = false
    var isOrdered: Bool = false
    var isOnCart: Bool = false
    
    init(id: Int, title: String, productDescription: String, category: String, price: Double, shippingInformation: String, image: String, isFavorite: Bool, isOrdered: Bool, isOnCart: Bool) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.category = category
        self.price = price
        self.shippingInformation = shippingInformation
        self.image = image
        self.isFavorite = isFavorite
        self.isOrdered = isOrdered
        self.isOnCart = isOnCart
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case productDescription = "description"
        case category
        case price
        case shippingInformation
        case image
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

