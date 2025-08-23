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
        let viewModel = APIViewModel(service: APIService.shared)
        
        //when
        await viewModel.loadProducts()
        
        //then
        #expect(viewModel.products.count > 1)
        
    }

}
