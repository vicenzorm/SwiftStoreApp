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
    var orders: [UserProduct] = []
    var favorites: [UserProduct] = []
    var cartList: [UserProduct] = []
    
    init(orders: [UserProduct], favorites: [UserProduct], cartList: [UserProduct]) {
        self.orders = orders
        self.favorites = favorites
        self.cartList = cartList
    }
}
