//
//  ProductViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

protocol APIViewModelProtocol {
    var products: [Product] { get }
    var categories: [Category] { get }
    var isLoadingProducts: Bool { get }
    var isLoadingCategories: Bool { get }
    var errorMessage: String? { get }
    var filteredProdcuts: [Product] { get }
    
    func loadProducts() async
    func loadCategories() async
    func loadProductsByCategories(category: String) async
    
    func filterProductByName(name: String)
}
