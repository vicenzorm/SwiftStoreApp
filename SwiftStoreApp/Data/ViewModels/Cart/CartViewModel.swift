//
//  CartViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation
@Observable
class CartViewModel {
    var cartItems: [Product] = []
    var cart: [Cart] = [] // IDs + quantidade
    
    let apiService: APIService = .shared
    let cartService: CartService = .shared
    
    func fetchCartItems() {
        Task {
            var products: [Product] = []
            for item in cart {
                if let product = try? await apiService.getProductByID(productId:item.id) {
                    // Atualiza a quantidade conforme no cart
                    product.quantity = item.quantity
                    products.append(product)
                }
            }
            self.cartItems = products
        }
    }
    
    @MainActor
    func addToCart(productId: Int) {
        cartService.addToCart(productId: productId)
    }
    
    @MainActor
    func removeFromCart(productId: Int) {
        cartService.removeFromCart(productId: productId)
    }
    
    @MainActor
    func updateQuantity(productId: Int, newQuantity: Int) {
        cartService.updateQuantity(productId: productId, newQuantity: newQuantity)
    }
    
    //func addCart n sei com faria pra adicionar no carrinho
    
}
