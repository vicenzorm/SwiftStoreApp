//
//  File.swift
//  TestsForSwiftStore
//
//  Created by Vicenzo Másera on 27/08/25.
//

import Foundation
@testable import SwiftStoreApp

class APIServiceMock: APIServiceProtocol {
    
    var shouldFail: Bool = false
    var products: [SwiftStoreApp.Product]
    var product: SwiftStoreApp.Product
    var categories: [SwiftStoreApp.Category]
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.products = [ProductMock.iphone.mockado, ProductMock.macbookAir.mockado]
        self.product = ProductMock.iphone.mockado
        self.categories = [SwiftStoreApp.Category(name: "", slug: "")]
    }
    
    func getAllProducts() async throws -> [SwiftStoreApp.Product] {
        if !shouldFail {
            return products
        } else {
            throw NSError(domain: #function, code: 0)
        }
    }
    
    func getAllCategories() async throws -> [SwiftStoreApp.Category] {
        if !shouldFail {
            return categories
        } else {
            throw NSError(domain: #function, code: 1)
        }
    }
    
    func getProductsByCategories(category: String) async throws -> [SwiftStoreApp.Product] {
        if !shouldFail {
            return products
        } else {
            throw NSError(domain: #function, code: 2)
        }
    }
    
    func getProduct(byId: Int) async throws -> SwiftStoreApp.Product {
        if !shouldFail {
            return product
        } else {
            throw NSError(domain: #function, code: 3)
        }
    }
}


// HELPED BY ALEXA FRAGA
