//
//  FavoritesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol FavoritesViewModelProtocol {
    var favorites: [Favorite] { get }    
    func getFavoriteById(id: Int) -> Favorite?
    func loadFavoriteProducts() async
    func addToFavorites(product: Product)
    func filterFavorites(textToSearch: String)
    func isProductFavorite(product: Product) -> Bool
}
