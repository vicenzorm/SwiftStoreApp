//
//  CartServiceMock.swift
//  TestsForSwiftStore
//
//  Created by Vicenzo Másera on 07/10/25.
//

import Foundation
@testable import SwiftStoreApp

@MainActor
class CartServiceMock: CartServiceProtocol {
    
    // Itens mockados no carrinho (IDs que correspondem aos mocks de produto)
    var cart: [Cart] = [
        Cart(id: ProductMock.iphone.mockado.id, quantity: 2),
        Cart(id: ProductMock.macbookAir.mockado.id, quantity: 1)
    ]
    
    var addToCartCalled = false
    var updateQuantityCalled = false
    var clearCartCalled = false

    func fetchCart() -> [Cart] {
        return cart
    }

    func addToCart(productId: Int) {
        addToCartCalled = true
        if let existing = cart.first(where: { $0.id == productId }) {
            existing.quantity += 1
        } else {
            cart.append(Cart(id: productId, quantity: 1))
        }
    }

    func removeFromCart(productId: Int) {
        cart.removeAll { $0.id == productId }
    }

    func updateQuantity(productId: Int, newQuantity: Int) {
        updateQuantityCalled = true
        if let index = cart.firstIndex(where: { $0.id == productId }) {
            if newQuantity <= 0 {
                cart.remove(at: index)
            } else {
                cart[index].quantity = newQuantity
            }
        }
    }
    
    func clearCart() {
        clearCartCalled = true
        cart.removeAll()
    }
}
