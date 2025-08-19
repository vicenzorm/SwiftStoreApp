//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

@Observable
class UserViewModel: UserViewModelProtocol {
    
    var favoriteProducts: [UserProduct] = []
    var orderedProducts: [UserProduct] = []
    var productsOnCart: [UserProduct] = []
    
    private let service: UserServiceProtocol
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func addToCart(product: Product) {
        service.addToCart(product: product)
        productsOnCart = getProductsOnCart()
    }
    
    func addToFav(product: Product) {
        service.addToFavorites(product: product)
        favoriteProducts = getFavoriteProducts()
    }
    
    func addToOrder() {
        service.checkoutOrders()
        productsOnCart = getOrderedProducts()
    }
    
    func getFavoriteProducts() -> [UserProduct] {
        let favoriteProducts = service.getAllFavorites()
        return favoriteProducts
    }
    
    func getOrderedProducts() -> [UserProduct] {
        let orderedProducts = service.getAllOrders()
        return orderedProducts
    }
    
    func getProductsOnCart() -> [UserProduct] {
        let cartProducts = service.getCartListProducts()
        return cartProducts
    }
    
}
