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
    func getAllFavorites() -> [Favorite]
    func getFavoriteById(id: Int) -> Favorite?
    
}
