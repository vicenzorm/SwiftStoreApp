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
        await viewModel.addToFavorites(product: <#T##Product#>)
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
    
    
}
