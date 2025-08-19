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
    var products: [UserProduct]
    
    init(products: [UserProduct]) {
        self.products = products
    }
}
