//
//  ProductServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

protocol APIServiceProtocol {
    func getAllProducts() async throws -> [Product]
    func getAllCategories() async throws -> [Category]
    func getProductsByCategories(category: String) async throws -> [Product]
    func getProduct(byId: Int) async throws -> Product
}
