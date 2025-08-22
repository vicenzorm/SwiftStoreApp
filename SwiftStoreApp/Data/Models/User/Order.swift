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
    var name: String
    
    init(id: Int, day: Int, price: Double, name: String) {
        self.id = id
        self.day = day
        self.price = price
        self.name = name
    }
}
