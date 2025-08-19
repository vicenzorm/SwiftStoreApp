//
//  File.swift
//  SwiftStoreApp
//
//  Created by Vítor Bruno on 14/08/25.
//

import Foundation

protocol UserViewModelProtocol {
    var favoriteProducts: [UserProduct] { get }
    var orderedProducts: [UserProduct] { get }
    var productsOnCart: [UserProduct] { get }
    
    func addToCart(product: Product)
    func addToFav(product: Product)
    func addToOrder()
    
    func getFavoriteProducts() -> [UserProduct]
    func getOrderedProducts() ->  [UserProduct]
    func getProductsOnCart() ->  [UserProduct]
}
