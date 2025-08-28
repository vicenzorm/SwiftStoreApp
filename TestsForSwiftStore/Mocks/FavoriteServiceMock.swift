//
//  File.swift
//  TestsForSwiftStore
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Foundation
@testable import SwiftStoreApp

class FavoriteServiceMock: FavoritesServiceProtocol {
    
    var shouldFail: Bool = false
    var favorites: [Favorite]
    var addedFavorite = false
    var removedFavorite = false
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.favorites = [Favorite(id: 0)]
        
    }
    
    func addFavorite(productId: Int) {
        addedFavorite.toggle()
    }
    
    func getAllFavorites() -> [SwiftStoreApp.Favorite] {
        return favorites
    }
    
    func getFavoritesById(id: Int) -> SwiftStoreApp.Favorite? {
        return favorites.first(where: {$0.id == id })
    }
    
    func removeFavorite(productId: Int) {
        removedFavorite.toggle()
    }
    
    
}
