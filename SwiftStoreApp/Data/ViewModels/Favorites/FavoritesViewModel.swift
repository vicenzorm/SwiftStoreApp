//
//  FavoritesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 21/08/25.
//

import Foundation

@Observable
@MainActor
class FavoritesViewModel {
    
    // This is the list the View will display. It holds the full Product objects.
    var favoriteProducts: [Product] = []
    
    // A private, complete list that we use as a "master copy" for filtering.
    private var allFavoriteProducts: [Product] = []
    
    private let favoritesService: FavoritesServiceProtocol
    private let productService: APIServiceProtocol

    init(favoritesService: FavoritesServiceProtocol, productService: APIServiceProtocol) {
        self.favoritesService = favoritesService
        self.productService = productService
    }
    
    // prepara tuuuuudo
    func loadFavoriteProducts() async {
        // pega todos os ids
        let favoriteIDs = favoritesService.getAllFavorites().map { $0.id }
        
        var foundProducts: [Product] = []
        for id in favoriteIDs {
            do {
                // pega produto por produto por id  
                let product = try await self.productService.getProduct(byId: id)
                foundProducts.append(product)
            } catch {
                print("Failed to fetch product with ID \(id): \(error)")
            }
        }
        self.allFavoriteProducts = foundProducts
        self.favoriteProducts = foundProducts
    }
    
    func filterFavorites(textToSearch: String) {
        if textToSearch.isEmpty {
           //filtered products serao todos os produtos se nao tiver nenhum texto
            favoriteProducts = allFavoriteProducts
        } else {
//            se nao ira filtrar pelo texto inputado
            favoriteProducts = allFavoriteProducts.filter { product in
                product.title.localizedCaseInsensitiveContains(textToSearch)
            }
        }
    }
    
    // vai servir para checar se um produto esta favoritado ou nao na tela inicial
    func isProductFavorite(product: Product) -> Bool {
        return favoritesService.getFavoritesById(id: product.id) != nil
    }
}
