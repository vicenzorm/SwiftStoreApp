//
//  UserServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 18/08/25.
//

import Foundation

@MainActor
protocol UserServiceProtocol {
    
    func addToFavorites(product: Product) async
    func addToCart(product: Product) async 
    func checkoutOrders()
    
    func getAllFavorites() -> [UserProduct]
    func getCartListProducts() -> [UserProduct]
    func getAllOrders() -> [UserProduct]
    func getCartPrice() -> Double
    
}
