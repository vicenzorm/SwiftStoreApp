//
//  CartViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
@Observable
class CartViewModel {
    var cartItems: [Product] = []
    private var cart: [Cart] = [] // IDs + quantidade
    
    let apiService: APIService = .shared
    let cartService: CartService = .shared
    
    func loadCart() {
        self.cart = cartService.fetchCart()
        
        Task {
            await fetchProductsFullDetails()
        }
    }
    
    func fetchProductsFullDetails() async {
        var cartProducts: [Product] = []
        
        for item in cart {
            do {
                let product = try await apiService.getProduct(byId: item.id)
                product.quantity = item.quantity
                cartProducts.append(product)
                
            } catch {
                print("Error fetching all products")
            }
        }
        
        self.cartItems = cartProducts
    }
    
    func addToCart(productId: Int) {
        cartService.addToCart(productId: productId)
        loadCart()
    }
    
    func removeFromCart(productId: Int) {
        cartService.removeFromCart(productId: productId)
        loadCart()
    }
    
    func updateQuantity(productId: Int, newQuantity: Int) {
        cartService.updateQuantity(productId: productId, newQuantity: newQuantity)
    }
    
    func getCartTotalPrice() -> Double {
        return cartItems.reduce(0.0) { total, item in
            total + (item.price * Double(item.quantity))
        }
    }
    
    func clearCart() {
        cartService.clearCart()
        cartItems.removeAll()
        cart.removeAll()
    }
    
}
