//
//  HomeViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Testing
@testable import SwiftStoreApp

struct HomeViewModelTests {

    @Test func fetchProducts() async throws {
        
        // Given
        let favService = await FavoriteServiceMock(shouldFail: false)
        let apiService = await APIServiceMock()
        let viewModel = await HomeViewModel(apiService: APIService.shared, favoritesService: Persistence.shared.favoriteService)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func addToFavorites() async throws {
        
        // Given
        let viewModel = await HomeViewModel(apiService: APIService.shared, favoritesService: Persistence.shared.favoriteService)
        
        // When
        await viewModel.addToFavorites(product: ProductMock.iphone.mockado)
        
        // Then
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.products.contains(ProductMock.iphone.mockado))
    }
    
    
}
