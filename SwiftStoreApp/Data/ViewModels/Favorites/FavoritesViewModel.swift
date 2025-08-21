//
//  FavoritesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@Observable
@MainActor
class FavoritesViewModel: FavoritesViewModelProtocol {
   
    var favorites: [Favorite] = []
    
    private let service: FavoritesServiceProtocol
    
    init(service: FavoritesServiceProtocol) {
        self.service = service
    }
    
    func getAllFavorites() -> [Favorite] {
        favorites = service.getAllFavorites()
        return favorites
    }
    
    func getFavoriteById(id: Int) -> Favorite? {
        var favorite = service.getFavoritesById(id: id)
        return favorite
    }
}
