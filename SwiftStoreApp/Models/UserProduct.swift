//
//  Product.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation
import SwiftData

@Model
class UserProduct: Identifiable {
    var id: Int
    var title: String
    var productDescription: String
    var price: Double
    var shippingInformation: String
    var image: String
    var isFavorite: Bool = false
    var isOrdered: Bool = false
    var isOnCart: Bool = false
    
    init(id: Int, title: String, productDescription: String, price: Double, shippingInformation: String, image: String, isFavorite: Bool, isOrdered: Bool, isOnCart: Bool) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.price = price
        self.shippingInformation = shippingInformation
        self.image = image
        self.isFavorite = isFavorite
        self.isOrdered = isOrdered
        self.isOnCart = isOnCart
    }
}
