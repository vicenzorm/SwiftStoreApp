//
//  HomeViewModelProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@Observable
@MainActor
class CartViewModel {
    var cartItems: [Product] = []
    private var cart: [Cart] = []
    
    let apiService: APIService = .shared
    let cartService: CartService = Persistence.shared.cartService
    let orderService: OrdersService = Persistence.shared.orderService
    
    func loadCart() async {
        self.cart = cartService.fetchCart()
        print("🛒 Carrinho local carregado. Itens no banco de dados: \(self.cart.count)")
        
        Task {
            await fetchProductsFullDetails()
        }
    }
    
    func fetchProductsFullDetails() async {
        var cartProducts: [Product] = []
        print("Buscando detalhes completos dos produtos na API...")
        for item in cart {
            do {
                let product = try await apiService.getProduct(byId: item.id)
                product.quantity = item.quantity
                cartProducts.append(product)
            } catch {
                print("🚨 ERRO ao buscar detalhes do produto com id \(item.id): \(error)")
            }
        }
        self.cartItems = cartProducts
        print("✅ Detalhes de \(self.cartItems.count) produtos carregados. UI será atualizada.")
    }
    
    func updateQuantity(productId: Int, newQuantity: Int) {
        print("Atualizando quantidade do produto \(productId) para \(newQuantity)...")
        cartService.updateQuantity(productId: productId, newQuantity: newQuantity)
        
        if let index = cartItems.firstIndex(where: { $0.id == productId }) {
            cartItems[index].quantity = max(newQuantity, 0)
        }
    }
    
    func getCartTotalPrice() -> Double {
        return cartItems.reduce(0.0) { total, item in
            total + (item.price * Double(item.quantity))
        }
    }
    
    func clearCart() {
        print("Limpando todos os itens do carrinho...")
        cartService.clearCart()
        
        self.cartItems = []
        self.cart = []
    }
    
    func checkoutCart() {
        
        var productsId: [Int] = []
        
        for item in cartItems {
            productsId.append(item.id)
        }
        
        orderService.createOrder(productsId: productsId)
        clearCart()
    }
    
}
