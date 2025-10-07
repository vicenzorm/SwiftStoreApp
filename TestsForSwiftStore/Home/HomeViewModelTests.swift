import Testing
@testable import SwiftStoreApp

struct HomeViewModelTests {
    
    @Test func loadProducts_success() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: false)
        let favMock = await FavoriteServiceMock(shouldFail: false)
        let viewModel =  HomeViewModel(apiService: apiMock, favoritesService: favMock)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func loadProducts_failure_setsError() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: true)
        let favMock = await FavoriteServiceMock()
        let viewModel =  HomeViewModel(apiService: apiMock, favoritesService: favMock)
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test func addToFavorites_callsService() async throws {
        // Given
        let apiMock = APIServiceMock()
        let favMock = await FavoriteServiceMock()
        let viewModel = await HomeViewModel(apiService: apiMock, favoritesService: favMock)
        
        // When
        await viewModel.addToFavorites(product: ProductMock.iphone.mockado)
        
        // Then
//        await #expect(favMock.addedFavorite == true)
        await #expect(viewModel.isProductFavorite(product: ProductMock.iphone.mockado) == true)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func isFavorite() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: false)
        let favMock = await FavoriteServiceMock(shouldFail: false)
        let viewModel = await HomeViewModel(apiService: APIServiceMock(shouldFail: false), favoritesService: FavoriteServiceMock(shouldFail: false) )
        
        let product = ProductMock.iphone.mockado
        
        // When
        let binding = await viewModel.isProductFavorite(product: product)
        
        #expect(binding == true)
        
    }
    
}
