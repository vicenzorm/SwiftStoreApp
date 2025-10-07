//
//  FavoriteViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 23/08/25.
//

import Testing
@testable import SwiftStoreApp
import Foundation

@MainActor
struct FavoritesViewModelTests {
    
    let product1 = ProductMock.iphone.mockado
    let product2 = ProductMock.macbookAir.mockado
    
    class TestableAPIMock: APIServiceMock {
        override func getProduct(byId id: Int) async throws -> Product {
            if id == ProductMock.iphone.mockado.id {
                return ProductMock.iphone.mockado
            }
            if id == ProductMock.macbookAir.mockado.id {
                return ProductMock.macbookAir.mockado
            }
            throw NSError(domain: "Test", code: 404)
        }
    }
    
    @Test func loadFavoriteProducts_success() async throws {
        // Given
        let apiMock = TestableAPIMock(shouldFail: false)
        let favMock = FavoriteServiceMock()
        // Mock com dois favoritos (IDs 0 e 1)
        favMock.favorites = [Favorite(id: product1.id), Favorite(id: product2.id)]
        let viewModel = FavoritesViewModel(favoritesService: favMock, productService: apiMock)
        
        // When
        await viewModel.loadFavoriteProducts()
        
        // Then
        #expect(!viewModel.favoriteProducts.isEmpty)
        #expect(viewModel.favoriteProducts.count == 2)
    }
    
    @Test func filteredFavorite_emptySearch_returnsAll() async {
        // Given
        let apiMock = APIServiceMock()
        let favMock = FavoriteServiceMock()
        let viewModel = FavoritesViewModel(favoritesService: favMock, productService: apiMock)
        viewModel.favoriteProducts = [product1, product2]
        
        // When
        viewModel.searchText = ""
        
        // Then
        #expect(viewModel.filteredFavorite.count == 2)
    }
    
    @Test func filteredFavorite_withSearchText_returnsFiltered() async {
        // Given
        let apiMock = APIServiceMock()
        let favMock = FavoriteServiceMock()
        let viewModel = FavoritesViewModel(favoritesService: favMock, productService: apiMock)
        
        let productWithLongTitle = ProductMock.produtoComNomeMuitoLongo.mockado
        productWithLongTitle.title = "A Product with a Long Name"
        product1.title = "Short Name"
        viewModel.favoriteProducts = [product1, productWithLongTitle]
        
        // When
        viewModel.searchText = "long name"
        
        // Then
        #expect(viewModel.filteredFavorite.count == 1)
        #expect(viewModel.filteredFavorite.first?.title == "A Product with a Long Name")
    }
    
    @Test func toggleFavorite_isFavorite_removesFromFavorites() async {
        // Given
        let apiMock = APIServiceMock()
        let favMock = FavoriteServiceMock()
        favMock.favorites = [Favorite(id: product1.id)] // Começa com product1 como favorito
        let viewModel = FavoritesViewModel(favoritesService: favMock, productService: apiMock)
        viewModel.favoriteProducts = [product1]
        
        // When
        await viewModel.toggleFavorite(product: product1)
        
        // Then
        #expect(favMock.removedFavorite == true)
        #expect(viewModel.favoriteProducts.isEmpty)
    }
}
