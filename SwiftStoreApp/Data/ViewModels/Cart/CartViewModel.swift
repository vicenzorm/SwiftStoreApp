//
//  CartViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation
@Observable
class CartViewModel {
    var cartItems: [Cart] = []
    var isLoadingCartItens: Bool = false
    
    private let service: CartService
    
    init() {
        self.service = CartService.shared
    }
    
    func fetchCartItems() async {
        isLoadingCartItens = true
        
         cartItems = await service.fetchCart()
        
        isLoadingCartItens = false
    }
    
    @MainActor
    func addToCart(productId: Int) {
        service.addToCart(productId: productId)
    }
    
    @MainActor
    func removeFromCart(productId: Int) {
        service.removeFromCart(productId: productId)
    }
    
    @MainActor
    func updateQuantity(productId: Int, newQuantity: Int) {
        service.updateQuantity(productId: productId, newQuantity: newQuantity)
    }
    
    //func addCart n sei com faria pra adicionar no carrinho
    
}
