import Testing
@testable import SwiftStoreApp

@MainActor
struct OrdersViewModelTests {
    
    @Test func loadOrders_success() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: false)
        let orderMock = await OrdersServiceMock(shouldFail: false)
        let viewModel = await OrdersViewModel(apiService: apiMock, orderService: orderMock)
        
        // When
        await viewModel.loadOrders()
        
        // Then
        await #expect(viewModel.orders.count == 2)
    }
    
    @Test func filteredOrders_emptySearch_returnsAll() async {
          // Given
          let apiMock = APIServiceMock(shouldFail: false)
          let orderMock = OrdersServiceMock(shouldFail: false)
          let viewModel = OrdersViewModel(apiService: apiMock, orderService: orderMock)
          
          viewModel.orders = [
            Product(id: 1, title: "iphone", description: "", category: "", price: 0.0, shippingInformation: "", thumbnail: "", quantity: 1),
            Product(id: 2, title: "iphone", description: "", category: "", price: 0.0, shippingInformation: "", thumbnail: "", quantity: 1),
          ]
          
          // When
          viewModel.textToSearch = ""
          
          // Then
         #expect(viewModel.filteredOrders.count == 2)
      }
    
    @Test func loadOrders_apiFailure() async throws {
        // Given
        let apiMock = APIServiceMock(shouldFail: true)
        let orderMock = await OrdersServiceMock(shouldFail: false)
        let viewModel = await OrdersViewModel(apiService: apiMock, orderService: orderMock)
        
        // When
        await viewModel.loadOrders()
        
        // Then
        await #expect(viewModel.orders.isEmpty)
    }
    
}
