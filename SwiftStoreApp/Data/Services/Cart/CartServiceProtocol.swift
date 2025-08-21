//
//  CartServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

protocol CartServiceProtocol {
    func fetchCart() -> [Cart]
    func addToCart(productId: Int)
}
