//
//  Cart.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import SwiftData
import Foundation

@Model
class Cart {
    var id: Int
    var quantity: Int
    
    init(id: Int, quantity: Int) {
        self.id = id
        self.quantity = quantity
    }
}
