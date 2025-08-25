//
//  CategoriesViewModelProtocol.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation

protocol CategoriesViewModelProtocol {
    var isLoadingCategories: Bool { get set }
        var errorMessage: String? { get set }
        var searchText: String { get set }
        var categories: [Category] { get set }
        var filteredCategories: [Category] { get }
        
        func loadCategories() async
}
