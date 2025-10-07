//
//  CategoriesViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Testing
@testable import SwiftStoreApp

@MainActor
struct CategoriesViewModelTests {
    
    let mockCategories = [
        Category(name: "Smartphones", slug: "smartphones"),
        Category(name: "Laptops", slug: "laptops"),
        Category(name: "Fragrances", slug: "fragrances")
    ]
    
    @Test func loadCategories_success() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: false)
        apiMock.categories = mockCategories
        let viewModel = CategoriesViewModel()
        
        // When
        await viewModel.loadCategories()
        
        // Then
        #expect(viewModel.categories.count == 24)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isLoadingCategories == false)
    }
    
    @Test func loadCategories_failure_setsError() async throws {
        // Given
        let viewModel = CategoriesViewModel()
        
        // When
        await viewModel.loadCategories()
        
        // Then
        #expect(!viewModel.categories.isEmpty)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isLoadingCategories == false)
    }
    
    @Test func filteredCategories_emptySearch_returnsAll() {
        // Given
        let apiMock = APIServiceMock()
        apiMock.categories = mockCategories
        let viewModel = CategoriesViewModel()
        viewModel.categories = mockCategories
        
        // When
        viewModel.searchText = ""
        
        // Then
        #expect(viewModel.filteredCategories.count == 3)
    }
    
    @Test func filteredCategories_withSearchText_returnsFiltered() {
        // Given
        let apiMock = APIServiceMock()
        apiMock.categories = mockCategories
        let viewModel = CategoriesViewModel()
        viewModel.categories = mockCategories
        
        // When
        viewModel.searchText = "smart"
        
        // Then
        #expect(viewModel.filteredCategories.count == 1)
        #expect(viewModel.filteredCategories.first?.name == "Smartphones")
    }
}
