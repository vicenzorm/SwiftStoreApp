//
//  FavoritesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@Observable
class FavoritesViewModel {
    var favoriteProducts: [Product] = []
    
    private let favoritesService: FavoritesServiceProtocol
    private let productService: APIServiceProtocol

    init(favoritesService: FavoritesServiceProtocol, productService: APIServiceProtocol) {
        self.favoritesService = favoritesService
        self.productService = productService
    }
    
    // prepara tuuuuudo
    func loadFavoriteProducts() async {
           let favoriteIDs = await favoritesService.getAllFavorites().map { $0.id }
           
           do {
               var foundProducts: [Product] = []
               for id in favoriteIDs {
                   let product = try await self.productService.getProduct(byId: id)
                   foundProducts.append(product)
               }
               
               // Atribui os resultados para as listas, atualizando a UI
               self.favoriteProducts = foundProducts
               
           } catch {
               print("Error loading favorite products: \(error)")
           }
       }
    
    func filterFavorites(textToSearch: String) -> [Product] {
        if textToSearch.isEmpty {
           //filtered products serao todos os produtos se nao tiver nenhum texto
            return favoriteProducts
        } else {
//            se nao ira filtrar pelo texto inputado
            return favoriteProducts.filter { product in
                product.title.localizedCaseInsensitiveContains(textToSearch)
            }
        }
    }
    
    @MainActor func addToFavorites(product: Product) {
        favoritesService.addFavorite(productId: product.id)
    }
    
    // vai servir para checar se um produto esta favoritado ou nao na tela inicial
    @MainActor func isProductFavorite(product: Product) -> Bool {
        return favoritesService.getFavoritesById(id: product.id) != nil
    }
    
    @MainActor func toggleFavorite(product: Product) {
        if isProductFavorite(product: product) {
            favoritesService.removeFavorite(productId: product.id)
            favoriteProducts.removeAll { $0.id == product.id }
        } else {
            favoritesService.addFavorite(productId: product.id)
            favoriteProducts.append(product)
        }
    }
}
