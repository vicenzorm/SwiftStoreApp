//
//  ProductServiceProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

class ShopService: ShopServiceProtocol {
    var baseUrl: String = "https://dummyjson.com/products"
    
    func getAllProducts() async throws -> [Product] {
        let urlString = baseUrl
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return response.products
    }
    
    func getAllCategories() async throws -> [Category] {
        let urlString = "\(baseUrl)categories"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([Category].self, from: data)
        return response
    }
    
    func getProductsByCategories(category: String) async throws -> [Product] {
        let urlString = "\(baseUrl)category/\(category)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)
        
        return response.products
    }
}
