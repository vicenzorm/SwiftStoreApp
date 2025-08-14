//
//  Product.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

struct ProductsResponse: Decodable {
    var products: [Product]
}

struct Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var shippingInformation: String
    var image: String
    var isFavorite: Bool = false
    var isOrdered: Bool = false
    var isOnCart: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
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
