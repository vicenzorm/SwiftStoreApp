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
    var isFavorited: Bool = false
    
    private let apiService: APIServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    private let cartService: CartServiceProtocol
    
    init(apiService: APIServiceProtocol, favoritesService: FavoritesServiceProtocol, cartService: CartServiceProtocol) {
        self.apiService = apiService
        self.favoritesService = favoritesService
        self.cartService = cartService
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
        favoritesService.addFavorite(productId: product.id)
    }
}
