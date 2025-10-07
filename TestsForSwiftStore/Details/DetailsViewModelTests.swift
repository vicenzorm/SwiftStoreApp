//
//  DetailsViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Testing
@testable import SwiftStoreApp

@MainActor
struct DetailsViewModelTests {
    
    let viewModel: DetailsViewModel!
    let mockApi: APIServiceMock
    let mockFavoritesService: FavoriteServiceMock
    let mockCartService: CartServiceMock
    
    init() {
        self.mockApi = APIServiceMock()
        self.mockFavoritesService = FavoriteServiceMock(shouldFail: false)
        self.mockCartService = CartServiceMock()
        
        viewModel = DetailsViewModel(apiService: self.mockApi, favoritesService: self.mockFavoritesService, cartService: self.mockCartService, isFavorite: false)
    }
    
    @Test()
    func addCartShouldCallService() {
        
        let product = ProductMock.iphone.mockado
        
        viewModel.addToCart(product: product)
        
        #expect(self.mockCartService.addToCartCalled == true)
    }
    
    @Test()
    func isProductFavoriteShouldReturnTrue() {
        
        let product = ProductMock.iphone.mockado
        
        mockFavoritesService.favorites = [Favorite(id: product.id)]
        
        let isFavorite = viewModel.isProductFavorite(product: product)
        
        #expect(isFavorite == true)
    }
    
    @Test()
    func isProductFavoriteShouldReturnFalse() async throws {
        let notFavoriteProduct = ProductMock.macbookAir.mockado
        
        mockFavoritesService.favorites = []
        
        let isFavorite = viewModel.isProductFavorite(product: notFavoriteProduct)
        
        #expect(isFavorite == false)
    }
    
    @Test()
    func addToFavoriteShouldToggleStatus() {
        let product = ProductMock.macbookAir.mockado
        mockFavoritesService.favorites = []
        viewModel.isFavorited = false
        
        #expect(viewModel.isFavorited == false)
        
        viewModel.addToFavorites(product: product)
        
        #expect(mockFavoritesService.addedFavorite == true)
        #expect(mockFavoritesService.removedFavorite == false)
        #expect(viewModel.isFavorited == true)
    }
    
    @Test()
    func productShouldBeUnfavorited() async throws {
        let product = ProductMock.iphone.mockado
        mockFavoritesService.favorites = [Favorite(id: product.id)]
        viewModel.isFavorited = true
        
        viewModel.addToFavorites(product: product)
        
        #expect(mockFavoritesService.addedFavorite == false)
        #expect(mockFavoritesService.removedFavorite == true)
        #expect(viewModel.isFavorited == false)
    }
}
