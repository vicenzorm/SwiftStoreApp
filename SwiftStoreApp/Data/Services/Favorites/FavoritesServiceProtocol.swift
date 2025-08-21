//
//  FavoritesServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@MainActor
protocol FavoritesServiceProtocol {
    func addFavorites(productId: Int)
    func getaAllFavorites() -> [Int]
    func getFavoritesById(id: Int) -> Int
}
