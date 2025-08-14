//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation
import SwiftData

@Model
class User {
    var orders: [Product] = []
    var favorites: [Product] = []
    var cartList: [Product] = []
    
    init(orders: [Product], favorites: [Product], cartList: [Product]) {
        self.orders = orders
        self.favorites = favorites
        self.cartList = cartList
    }
}
