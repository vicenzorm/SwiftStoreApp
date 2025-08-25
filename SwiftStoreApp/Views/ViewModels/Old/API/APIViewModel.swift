//
//  ProductViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

@Observable
class APIViewModel: APIViewModelProtocol {
    var filteredProdcuts: [Product] = []
    var isLoadingProducts: Bool = false
    var isLoadingCategories: Bool = false
    var products: [Product] = []
    var categories: [Category] = []
    var errorMessage: String?
    
    private let service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        isLoadingProducts = true
        do {
            products = try await service.getAllProducts()
        } catch {
            errorMessage = "Error at fetching products: \(error.localizedDescription)"
        }
        isLoadingProducts = false
    }
    
    func loadCategories() async {
        isLoadingCategories = true
        do{
            categories = try await service.getAllCategories()
        } catch {
            errorMessage = "Error at fetching categories: \(error.localizedDescription)"
        }
        
        isLoadingCategories = false
    }
    
    func loadProductsByCategories(category: String) async {
        isLoadingProducts = true
            
        do {
            filteredProdcuts = try await service.getProductsByCategories(category: category)
        } catch {
            errorMessage = "Error at fetching filtered products: \(error.localizedDescription)"
        }
        isLoadingProducts = false
    }
    
    func filterProductByName(name: String) {
        //
    }
}
