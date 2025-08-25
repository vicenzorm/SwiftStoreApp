//
//  CategoriesViewModel.swift
//  SwiftStoreApp
//
//  Created by Vicenzo Másera on 25/08/25.
//

import Foundation
import SwiftUI

@Observable
class CategoriesViewModel: CategoriesViewModelProtocol {
    
    let baseUrl = "https://dummyjson.com/products"
    let apiService: APIService = APIService.shared
    
    var isLoadingCategories: Bool = false
    var errorMessage: String?
    var searchText: String = ""
    var categories: [Category] = []
    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadCategories() async {
        isLoadingCategories = true
        do{
            categories = try await apiService.getAllCategories()
        } catch {
            errorMessage = "Error at fetching categories: \(error.localizedDescription)"
        }
        isLoadingCategories = false
    }
    
    
}
