//
//  DetailsViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@Observable
@MainActor
class DetailsViewModel: DetailsViewModelProtocol {
    var isLoadingProduct: Bool = false
    var errorMessage: String?
    var isFavorited: Bool
    
    private let apiService: APIServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    private let cartService: CartServiceProtocol
    
    init(apiService: APIServiceProtocol, favoritesService: FavoritesServiceProtocol, cartService: CartServiceProtocol, isFavorite: Bool) {
        self.apiService = apiService
        self.favoritesService = favoritesService
        self.cartService = cartService
        self.isFavorited = isFavorite
    }
    
    // vai servir para checar se um produto esta favoritado ou nao na tela inicial
    @MainActor
    func isProductFavorite(product: Product) -> Bool {
        return favoritesService.getFavoritesById(id: product.id) != nil
    }
    
    func addToCart(product: Product) {
        cartService.addToCart(productId: product.id)
    }
    
    @MainActor
    func addToFavorites(product: Product) {
        if favoritesService.getFavoritesById(id: product.id) != nil {
            favoritesService.removeFavorite(productId: product.id)
            self.isFavorited = false
        } else {
            favoritesService.addFavorite(productId: product.id)
            self.isFavorited = true
        }
    }
}
