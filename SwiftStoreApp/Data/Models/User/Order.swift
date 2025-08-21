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
    
    init(id: Int, day: Int) {
        self.id = id
        self.day = day
    }
}
