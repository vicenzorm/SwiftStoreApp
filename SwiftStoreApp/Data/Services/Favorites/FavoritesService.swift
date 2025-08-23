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
            return []
        }
    }
    
    func getFavoritesById(id: Int) -> Favorite? {
        let predicate = #Predicate<Favorite> { $0.id == id }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Erro ao dar fetch")
        }
        
        return nil
    }
    
    func removeFavorite(productId: Int) {
        let predicate = #Predicate<Favorite> { $0.id == productId }
        let descriptor = FetchDescriptor<Favorite>(predicate: predicate)

        do {
            if let favoriteToDelete = try modelContext.fetch(descriptor).first {
                modelContext.delete(favoriteToDelete)
                try modelContext.save()
            }
        } catch {
            print("Erro ao remover favorito: \(error.localizedDescription)")
        }
    }
    
}
