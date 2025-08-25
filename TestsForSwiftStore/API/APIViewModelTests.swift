//
//  APItesting.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 23/08/25.
//

import Testing
@testable import SwiftStoreApp

struct APIViewModelTests {

    @Test func testLoadProducts() async throws {
        //given
        let service = MockAPIService(shouldFail: false)
        let viewModel = APIViewModel(service: service)
        
        //when
        await viewModel.loadProducts()
        
        //then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.products != nil)
        #expect(viewModel.errorMessage == nil)
        
    }
    
    @Test func testLoadProductsShouldFail() async throws {
        //given
        let service = MockAPIService(shouldFail: true)
        let viewModel = APIViewModel(service: service)
        
        //when
        await viewModel.loadProducts()
        
        //then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.products == nil)
        #expect(viewModel.errorMessage != nil)
        
    }

}
