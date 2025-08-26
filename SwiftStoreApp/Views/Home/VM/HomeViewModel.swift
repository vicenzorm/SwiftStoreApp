//
//  HomeViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    var products: [Product] = []
    var isLoadingProducts: Bool = false
    var errorMessage: String?
    var isFavorited: Bool = false
    var selectedProduct: Product?
    
    private let apiService: APIServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    
    init(apiService: APIServiceProtocol, favoritesService: FavoritesServiceProtocol,) {
        self.apiService = apiService
        self.favoritesService = favoritesService
    }
    
    func loadProducts() async {
        isLoadingProducts = true
        do {
            products = try await apiService.getAllProducts()
        } catch {
            errorMessage = "Error at fetching products: \(error.localizedDescription)"
        }
        isLoadingProducts = false
    }
    
    // vai servir para checar se um produto esta favoritado ou nao na tela inicial
    @MainActor
    func isProductFavorite(product: Product) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.favoritesService.getFavoritesById(id: product.id) != nil
            },
            set: { newFavorite in
                if newFavorite {
                    self.favoritesService.addFavorite(productId: product.id)
                } else {
                    self.favoritesService.removeFavorite(productId: product.id)
                }
            }
        )
    }
    
    @MainActor func addToFavorites(product: Product) {
        favoritesService.addFavorite(productId: product.id)
    }
}
