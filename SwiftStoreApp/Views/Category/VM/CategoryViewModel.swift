//
//  CategoryViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

@Observable
@MainActor
class CategoryViewModel: CategoryViewModelProtocol{
    let apiService: APIServiceProtocol
    let favoritesService: FavoritesServiceProtocol = Persistence.shared.favoriteService
    
    var favoriteProducts: [Product] = []
    
    var selectedProduct: Product?
    var category: Category
    var isFavorited: Bool = false
    var isLoadingProducts: Bool = false
    var productsByCategorie: [Product] = []
    var searchText: String = ""
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return productsByCategorie
        } else {
            return productsByCategorie.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var errorMessage: String?
    
    
    init(category: Category, apiService: APIServiceProtocol) {
        self.category = category
        self.apiService = apiService
    }
    
    func loadProductsByCategories(category: String) async {
        isLoadingProducts = true
            
        do {
            productsByCategorie = try await apiService.getProductsByCategories(category: category)
        } catch {
            errorMessage = "Error at fetching filtered products: \(error.localizedDescription)"
        }
        isLoadingProducts = false
    }
    
    func loadFavoriteProducts() async {
        // pega todos os ids
        let favoriteIDs = favoritesService.getAllFavorites().map { $0.id }
        
        var foundProducts: [Product] = []
        for id in favoriteIDs {
            do {
                // pega produto por produto por id
                let product = try await apiService.getProduct(byId: id)
                foundProducts.append(product)
            } catch {
                print("Failed to fetch product with ID \(id): \(error)")
            }
        }
        self.favoriteProducts = foundProducts
    }
    
    func addToFavorites(product: Product) {
        favoritesService.addFavorite(productId: product.id)
    }
    
    // vai servir para checar se um produto esta favoritado ou nao na tela inicial
    func isProductFavorite(product: Product) -> Bool {
        return favoritesService.getFavoritesById(id: product.id) != nil
    }
    
    func toggleFavorite(product: Product) {
        if isProductFavorite(product: product) {
            favoritesService.removeFavorite(productId: product.id)
            favoriteProducts.removeAll { $0.id == product.id }
        } else {
            favoritesService.addFavorite(productId: product.id)
            favoriteProducts.append(product)
        }
    }
}
