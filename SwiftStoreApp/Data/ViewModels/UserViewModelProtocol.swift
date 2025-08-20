//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

@MainActor // colocado pra rodar na thread principal e alterar UI
protocol UserViewModelProtocol {
    var favoriteProducts: [UserProduct] { get }
    var orderedProducts: [UserProduct] { get }
    var productsOnCart: [UserProduct] { get }
    
    func addToCart(product: Product) async
    func addToFavorites(product: Product) async
    func addFavoritesToCart(userProduct: UserProduct)
    func addToOrder()
    
    func getFavoriteProducts() -> [UserProduct]
    func getOrderedProducts() ->  [UserProduct]
    func getProductsOnCart() ->  [UserProduct]
    func getCartTotalPrice() -> Double
}
