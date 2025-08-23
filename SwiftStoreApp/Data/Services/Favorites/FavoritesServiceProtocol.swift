//
//  FavoritesServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol FavoritesServiceProtocol {
    func addFavorite(productId: Int)
    func getAllFavorites() -> [Favorite]
    func getFavoritesById(id: Int) -> Favorite?
    func removeFavorite(productId: Int)  
}
