//
//  MockAPIService.swift
//  SwiftStoreAppTests
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation
@testable import SwiftStoreApp

class MockAPIService: APIServiceProtocol {
    
    var shouldFail: Bool = false
    private var product: Product
    private var category: Category
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
        self.product = Product(id: 0, title: "title of the product", description: "description of the product", category: "category of the product", price: 10.00, shippingInformation: "Tomorrow", thumbnail: "Image of the item in a URL", quantity: 0)
        self.category = Category(id: UUID(), name: "name of the cateogry", slug: "name lowercased", image: "image in url")
    }
    
    func getAllProducts() async throws -> [SwiftStoreApp.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return [product]
        }
    }
    
    func getAllCategories() async throws -> [SwiftStoreApp.Category] {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        } else {
            return [category]
        }
    }
    
    func getProductsByCategories(category: String) async throws -> [SwiftStoreApp.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 3)
        } else {
            return [product]
        }
    }
    
    func getProduct(byId: Int) async throws -> SwiftStoreApp.Product {
        if shouldFail {
            throw NSError(domain: #function, code: 4)
        } else {
            return product
        }
    }
}
