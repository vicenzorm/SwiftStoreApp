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
        
        try? await Task.sleep(for: .milliseconds(100))
        
        cart = cartViewModel.cartItems
        
        #expect(!cart.isEmpty == true)
    }
    
    @Test
    func apiServcieShouldFail() async {
        
        mockCartService.addToCart(productId: 999)
        mockApiService.shouldFail = true
        
        await cartViewModel.loadCart()
        
        try? await Task.sleep(for: .milliseconds(100))
        
        #expect(cartViewModel.cartItems.isEmpty == true)
        #expect(!cartViewModel.cartItems.contains { $0.id == 999 })
    }
    
    @Test()
    func updateQuantityShouldCallCartService() async throws {
        let iphone = ProductMock.iphone.mockado
        cartViewModel.cartItems = [iphone]
        let newQuantity = 5
        
        cartViewModel.updateQuantity(productId: iphone.id, newQuantity: newQuantity)
        
        #expect(mockCartService.updateQuantityCalled == true)
        #expect(cartViewModel.cartItems.isEmpty == false)
        #expect(cartViewModel.cartItems.first?.quantity == newQuantity)
    }
    
    @Test()
    func getCartTotalPriceShouldReturnRightValue() {
        let iphone = ProductMock.iphone.mockado
        cartViewModel.cartItems = [iphone]
        let newQuantity = 5
        
        cartViewModel.updateQuantity(productId: iphone.id, newQuantity: newQuantity)
        
        let cartPrice = cartViewModel.getCartTotalPrice()
        
        #expect(cartPrice == iphone.price * Double(newQuantity))
    }
    
    @Test()
    func clearCartShouldCallService() {
        let iphone = ProductMock.iphone.mockado
        let macBook = ProductMock.iphone.mockado
        cartViewModel.cartItems = [iphone, macBook]
        
        #expect(mockCartService.clearCartCalled == false)
        #expect(cartViewModel.cartItems.isEmpty == false)
        
        cartViewModel.checkoutCart()
        
        #expect(mockCartService.clearCartCalled == true)
        #expect(cartViewModel.cartItems.isEmpty == true)
        
        
    }
}
