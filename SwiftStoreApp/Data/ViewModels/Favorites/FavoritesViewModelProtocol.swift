//
//  FavoritesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol FavoritesViewModelProtocol {
    var favoriteProducts: [Product] { get }
    func loadFavoriteProducts() async
    func addToFavorites(product: Product)
    func filterFavorites(textToSearch: String)
    func isProductFavorite(product: Product) -> Bool
    //    func getFavoriteById(id: Int) -> Favorite?
}
