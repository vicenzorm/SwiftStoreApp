//
//  CategoryViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 27/08/25.
//
// SwiftStoreApp/TestsForSwiftStore/Category/CategoryViewModelTests.swift
import Testing
@testable import SwiftStoreApp
import Foundation

@MainActor
struct CategoryViewModelTests {
    
    let testCategory = Category(name: "Smartphones", slug: "smartphones")
    let product1 = ProductMock.iphone.mockado
    let product2 = ProductMock.macbookAir.mockado
    
    
    
    @Test func loadProductsByCategories_success() async throws {
        // Given
        let favMock = FavoriteServiceMock(shouldFail: false)
        let apiMock = APIServiceMock(shouldFail: false)
        apiMock.products = [product1, product2]
        
        Persistence.shared.favoriteService = FavoriteServiceMock(shouldFail: false)

        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)

        // When
        await viewModel.loadProductsByCategories(category: testCategory.slug)
        
        // Then
        #expect(viewModel.productsByCategorie.count == 2)
        #expect(viewModel.isLoadingProducts == false)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func loadProductsByCategories_failure_setsError() async throws {
        // Given
        let favMock = FavoriteServiceMock(shouldFail: true)
        let apiMock = APIServiceMock(shouldFail: true)
        
        Persistence.shared.favoriteService = FavoriteServiceMock(shouldFail: false)

        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)

        // When
        await viewModel.loadProductsByCategories(category: testCategory.slug)
        
        // Then
        #expect(viewModel.productsByCategorie.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test func filteredProducts_withSearchText_returnsFiltered() {
        // Given
        let favMock = FavoriteServiceMock(shouldFail: false)
        let apiMock = APIServiceMock(shouldFail: false)
        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)

        // Cria produtos com nomes distintos para testar o filtro
        let customProduct1 = Product(id: 10, title: "iPhone X", description: "", category: "", price: 0, shippingInformation: "", thumbnail: "", quantity: 1)
        let customProduct2 = Product(id: 20, title: "MacBook Air M2", description: "", category: "", price: 0, shippingInformation: "", thumbnail: "", quantity: 1)
        
        viewModel.productsByCategorie = [customProduct1, customProduct2]
        
        // When
        viewModel.searchText = "macbook"
        
        // Then
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.filteredProducts.first?.title == "MacBook Air M2")
    }

    @Test func loadFavoriteProducts_success() async throws {
        // Given
        let favMock = FavoriteServiceMock(shouldFail: false)
        let apiMock = APIServiceMock(shouldFail: false)
        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)

        // When
        await viewModel.loadFavoriteProducts()
        
        // Then
        #expect(viewModel.favoriteProducts.count == 1)
    }

    @Test func isProductFavorite_returnsCorrectState() async throws {
        // Given
        let favMock = FavoriteServiceMock()
        favMock.favorites = [Favorite(id: product1.id)]
        let apiMock = APIServiceMock(shouldFail: false)
        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)
        
        // When & Then
        #expect(viewModel.isProductFavorite(product: product1) == true)
        #expect(viewModel.isProductFavorite(product: product2) == false)
    }
    
    @Test func toggleFavorite_isFavorite_removesFromFavorites() async throws {
        // Given
        let favMock = FavoriteServiceMock()
        favMock.favorites = [Favorite(id: product1.id)]
        let apiMock = APIServiceMock(shouldFail: false)
        
        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)
        
        await viewModel.loadFavoriteProducts()
        
        // When
        await viewModel.toggleFavorite(product: product1)
        
        // Then
        #expect(favMock.removedFavorite == true)
        #expect(!viewModel.favoriteProducts.contains(where: { $0.id == product1.id }))
    }
    
    @Test func toggleFavorite_notFavorite_addsToFavorites() async throws {
        // Given
        let favMock = FavoriteServiceMock()
        favMock.favorites.removeAll()
        let apiMock = APIServiceMock(shouldFail: false)
        
        let viewModel = CategoryViewModel(category: testCategory, apiService: apiMock, favoriteService: favMock)
        
        // When
        await viewModel.toggleFavorite(product: product2)
        
        // Then
        #expect(favMock.addedFavorite == true)
        #expect(viewModel.favoriteProducts.contains(where: { $0.id == product2.id }))
    }
}
