//
//  FavoritesService.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation
import SwiftData

@MainActor
class FavoritesService: FavoritesServiceProtocol {

    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    static let shared = FavoritesService()
    
    private init() {
        self.modelContainer = try! ModelContainer(for: Favorite.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func addFavorite(productId: Int) {
        let newFavorite = Favorite(id: productId)
        modelContext.insert(newFavorite)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllFavorites() -> [Favorite] {
        do {
            return try modelContext.fetch(FetchDescriptor<Favorite>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getFavoritesById(id: Int) -> Favorite? {
        let favorites = getAllFavorites()
        for favorite in favorites {
            if favorite.id == id {
                return favorite
            } 
        }
    }
}
