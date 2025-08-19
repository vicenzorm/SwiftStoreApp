//
//  UserServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import Foundation

protocol UserServiceProtocol {
    
    func addToFavorites(product: Product)
    func addToCart(product: Product)
    func checkoutOrders()
    
    func getAllFavorites() -> [UserProduct]
    func getCartListProducts() -> [UserProduct]
    func getAllOrders() -> [UserProduct]
    
}
