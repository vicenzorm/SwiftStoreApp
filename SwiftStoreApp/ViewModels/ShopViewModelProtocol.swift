//
//  ProductViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 13/08/25.
//

import Foundation

protocol ShopViewModelProtocol {
    var products: [Product] { get }
    var categories: [Category] { get }
    var isLoadingProducts: Bool { get }
    var isLoadingCategories: Bool { get }
    
    func loadProducts() async
    func loadCategories() async
    
    func filterProductByName(name: String)
    func filterProductByCategory(category: String)
}
