//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

@Observable
@MainActor
class UserViewModel: UserViewModelProtocol {
    
    var favoriteProducts: [UserProduct] = []
    
    var orderedProducts: [UserProduct] = []

    var productsOnCart: [UserProduct] = []
    
    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func addToCart(product: Product) async {
        await service.addToCart(product: product)
        productsOnCart = getProductsOnCart()
    }
    
    func addToFavorites(product: Product) async {
        await service.addToFavorites(product: product)
        favoriteProducts = getFavoriteProducts()
    }
    
    func addToOrder() {
        service.checkoutOrders()
        orderedProducts = getOrderedProducts()
        productsOnCart = getProductsOnCart() // pra atualizar e o carrinho ficar vazio
    }
    
    func getFavoriteProducts() -> [UserProduct] { service.getAllFavorites() }
    
    func getOrderedProducts() -> [UserProduct] { service.getAllOrders() }
    
    func getProductsOnCart() -> [UserProduct] { service.getCartListProducts() }
    // apenas mais estetico e clean
    
    func getCartTotalPrice() -> Double { service.getCartPrice() }
}
