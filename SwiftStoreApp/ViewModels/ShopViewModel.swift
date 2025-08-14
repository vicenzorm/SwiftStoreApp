//
//  ProductViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

@Observable
class ShopViewModel: ShopViewModelProtocol {
    
    var isLoadingProducts: Bool = false
    var isLoadingCategories: Bool = false
    var products: [Product] = []
    var categories: [Category] = []
    
    private let service: ShopServiceProtocol
    
    init(service: ShopServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        isLoadingProducts = true
        do {
            products = try await service.getAllProducts()
        } catch {
            
        }
        isLoadingProducts = false
    }
    func loadCategories() async {
        isLoadingCategories = true
        
        do{
            categories = try await service.getAllCategories()
        } catch {
            
        }
        
        isLoadingCategories = false
    }
    
    func filterProductByName(name: String) {
        <#code#>
    }
    func filterProductByCategory(category: String) {
        <#code#>
    }
}
