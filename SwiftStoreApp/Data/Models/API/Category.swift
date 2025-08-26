//
//  Category.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

struct Category: Decodable, Identifiable {
    var id = UUID()
    var name: String
    var slug: String
    var image: String {
        let lowercasedString = name.lowercased().replacingOccurrences(of: " ", with: "-")
        return lowercasedString.prefix(1).uppercased() + lowercasedString.dropFirst()
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case slug
    }
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
}

extension Category {
    var stringLocalized: String {
        switch slug {
        case "beauty": return String(localized: "Beauty")
        case "fragrances": return String(localized: "Fragrances")
        case "furniture": return String(localized: "Furniture")
        case "groceries": return String(localized: "Groceries")
        case "home-decoration": return String(localized: "Home Decoration")
        case "kitchen-accessories": return String(localized: "Kitchen Accessories")
        case "laptops": return String(localized: "Laptops")
        case "mens-shirts": return String(localized: "Men's Shirts")
        case "mens-shoes": return String(localized: "Men's Shoes")
        case "mens-watches": return String(localized: "Men's Watches")
        case "mobile-accessories": return String(localized: "Mobile Accessories")
        case "motorcycle": return String(localized: "Motorcycle")
        case "skin-care": return String(localized: "Skin Care")
        case "smartphones": return String(localized: "Smartphones")
        case "sports-accessories": return String(localized: "Sports Accessories")
        case "sunglasses": return String(localized: "Sunglasses")
        case "tablets": return String(localized: "Tablets")
        case "tops": return String(localized: "Tops")
        case "vehicle": return String(localized: "Vehicle")
        case "womens-bags": return String(localized: "Women's Bags")
        case "womens-dresses": return String(localized: "Women's Dresses")
        case "womens-jewellery": return String(localized: "Women's Jewellery")
        case "womens-shoes": return String(localized: "Women's Shoes")
        case "womens-watches": return String(localized: "Women's Watches")
        default: return name
        }
    }
}
