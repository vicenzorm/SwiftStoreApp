//
//  Order.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import SwiftData
import Foundation

@Model
class Order {
    var id: Int
    var day: Int
    var price: Double
    
    init(id: Int, day: Int, price: Double) {
        self.id = id
        self.day = day
        self.price = price
    }
}
