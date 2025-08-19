//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

@Observable
class UserViewModel: UserViewModelProtocol {
    
    var favoriteProducts: [UserProduct]
    var orderedProducts: [UserProduct]
    var productsOnCart: [UserProduct]
    
    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func addToCart(product: Product) {
        service.addToCart(product: product)
    }
    
    func addToFav(product: Product) {
        service.addToFavorites(product: product)
    }
    
    func addToOrder() {
        service.checkoutOrders()
    }
    
    func getFavoriteProducts() -> ([UserProduct]) -> [UserProduct] {
        favoriteProducts = service.getAllFavorites()
    }
    
    func getOrderedProducts() -> ([UserProduct]) -> [UserProduct] {
        orderedProducts = service.getAllOrders()
    }
    
    func getProductsOnCart() -> ([UserProduct]) -> [UserProduct] {
        productsOnCart = service.getCartListProducts()
    }
    
}
