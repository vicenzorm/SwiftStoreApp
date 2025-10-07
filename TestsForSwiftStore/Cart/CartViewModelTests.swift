//
//  CartViewModelTests.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 23/08/25.
//

import Testing
@testable import SwiftStoreApp

@MainActor
struct CartViewModelTests {

    let cartViewModel: CartViewModel!
    let mockApiService: APIServiceMock
    let mockCartService: CartServiceMock
    let mockOrdersService: OrdersServiceMock
    
    init() {
        self.mockApiService = APIServiceMock()
        self.mockCartService = CartServiceMock()
        self.mockOrdersService = OrdersServiceMock()
        
        self.cartViewModel = CartViewModel(apiservice: mockApiService, cartService: mockCartService, orderService: mockOrdersService)
    }
    
    @Test
    func cartShouldFetch() async {
        var cart = cartViewModel.cartItems
        #expect(cart.isEmpty == true)
        
        await cartViewModel.loadCart()
        
        cart = cartViewModel.cartItems
        
        #expect(!cart.isEmpty == true)
    }
    
}
