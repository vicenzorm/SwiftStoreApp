//
//  HomeViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@MainActor
protocol HomeViewModelProtocol {
    var cartItems: [Product] { get set }
    
    func loadCart() async
    func fetchProductsFullDetails() async
    func updateQuantity(productId: Int, newQuantity: Int)
    func getCartTotalPrice() -> Double
    func clearCart()
    func checkoutCart()
}
